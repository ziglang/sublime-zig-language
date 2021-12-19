import sublime
import sublime_plugin

import os
import subprocess
import sys
import threading
import time
import codecs
import signal
import html
from ast import literal_eval


def get_setting(view, opt, default):
    # strictly speaking, im not sure that `default` is needed since sublime text combines
    # the user's preferences with the default ones so they should already have defaults
    zig_settings = sublime.load_settings("Zig.sublime-settings")
    preferences_settings = sublime.load_settings("Preferences.sublime-settings")
    file_settings = preferences_settings.get(opt, zig_settings.get(opt, default))
    return view.settings().get(opt, file_settings)


class ProcessSink:
    def on_data(self, proc, data):
        pass

    def on_finished(self, proc):
        pass


class AsyncProcess:
    def __init__(self, args, cwd, sink):
        self.killed = False
        self.sink = sink

        # Hide the console window on Windows
        startupinfo = None
        if os.name == "nt":
            startupinfo = subprocess.STARTUPINFO()
            startupinfo.dwFlags |= subprocess.STARTF_USESHOWWINDOW

        self.proc = subprocess.Popen(
            args,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            startupinfo=startupinfo,
            cwd=cwd,
        )

        self.stdout_thread = threading.Thread(
            target=self.read_fileno, args=(self.proc.stdout, True)
        )

        self.stderr_thread = threading.Thread(
            target=self.read_fileno, args=(self.proc.stderr, False)
        )

    def start(self):
        self.start_time = time.time()
        self.stdout_thread.start()
        self.stderr_thread.start()

    def kill(self):
        if not self.killed:
            self.killed = True
            if sys.platform == "win32":
                # terminate would not kill process opened by the shell cmd.exe,
                # it will only kill cmd.exe leaving the child running
                startupinfo = subprocess.STARTUPINFO()
                startupinfo.dwFlags |= subprocess.STARTF_USESHOWWINDOW
                subprocess.Popen(
                    "taskkill /PID %d /T /F" % self.proc.pid, startupinfo=startupinfo
                )
            else:
                os.killpg(self.proc.pid, signal.SIGTERM)
                self.proc.terminate()

    def poll(self):
        return self.proc.poll() is None

    def exit_code(self):
        return self.proc.poll()

    def read_fileno(self, file, execute_finished):
        chunk_size = 2 ** 16
        decoder = codecs.getincrementaldecoder(self.sink.encoding)("replace")

        while True:
            data = decoder.decode(file.read(chunk_size))
            data = data.replace("\r\n", "\n").replace("\r", "\n")

            if len(data) > 0 and not self.killed:
                self.sink.on_data(self, data)
                continue
            else:
                if execute_finished:
                    self.stderr_thread.join()
                    self.sink.on_finished(self)
                break


class ZigBuildCommand(sublime_plugin.WindowCommand, ProcessSink):
    def __init__(self, window):
        super().__init__(window)
        self.panel_lock = threading.Lock()
        self.encoding = "utf-8"
        self.quiet = False
        self.panel = None
        self.proc = None

        self.show_errors_inline = True
        self.phantom_sets_by_buffer = {}
        self.errs_by_file = {}

    def is_enabled(self, kill=False, **kwargs):
        if kill:
            return (self.proc is not None) and self.proc.poll()
        return True

    def handle_args(args, cmd, build, vars):
        if build is not None and cmd is None:
            args.append("build")
            if isinstance(build, dict):
                step = build.get("step", "")
                step_args = build.get("args", [])
                if step != "":
                    args.append(step)
                if step_args != []:
                    args.append("--")
                    args.extend(step_args)
            elif isinstance(build, list):
                args.extend(build)
            elif isinstance(build, str):
                args.append(build)
        elif cmd is not None:
            if isinstance(cmd, list):
                args.extend(cmd)
            elif isinstance(cmd, str):
                args.append(cmd)

        return sublime.expand_variables(args, vars)

    def run(
        self, cmd=None, build=None, quiet=False, kill=False, update_phantoms_only=False
    ):
        if update_phantoms_only:
            if self.show_errors_inline:
                self.update_phantoms()
            return

        if kill and self.proc:
            self.proc.kill()
            return

        vars = self.window.extract_variables()
        working_dir = vars.get("file_path", vars["folder"])

        view = self.window.active_view()
        self.quiet = quiet or get_setting(view, "zig.quiet", quiet)

        with self.panel_lock:
            # Creating the panel implicitly clears any previous contents
            self.panel = self.window.create_output_panel("exec")

            settings = self.panel.settings()
            settings.set(
                "result_file_regex", r"^(?:.\/)?(\S.*):(\d*):(\d*): (?:[^:]*): (.*)$"
            )
            settings.set(
                "result_line_regex", r"^(?:\S.*):(\d*):(\d*): (?:[^:]*): (.*)$"
            )
            settings.set("result_base_dir", working_dir)
            self.window.create_output_panel("exec")

        if self.proc is not None:
            if self.proc.poll() is None:
                self.proc.terminate()
            self.proc = None

        args = [get_setting(view, "zig.executable", "zig")]
        args = ZigBuildCommand.handle_args(args, cmd, build, vars)

        self.proc = None
        if not self.quiet:
            print("Running " + " ".join(args))
            sublime.status_message("Building")

        show_panel_on_build = get_setting(view, "show_panel_on_build", True)
        if show_panel_on_build and not self.quiet:
            self.window.run_command("show_panel", {"panel": "output.exec"})

        self.hide_view_phantoms()
        self.show_errors_inline = get_setting(view, "show_errors_inline", True)
        self.should_update_phantoms = False

        try:
            self.proc = AsyncProcess(args, working_dir, self)
            self.proc.start()
        except Exception as e:
            self.write(None, str(e) + "\n")
            if not self.quiet:
                self.write(None, "[Finished]")

    def write(self, proc, data):
        with self.panel_lock:
            if proc != self.proc and proc:
                # a second process is running
                # and we don't want to pollute the output
                proc.kill()
                return

            # write to the panel
            self.panel.run_command("append", {"characters": data})

            # collect any errors
            # errors are stored per file/line/column to make removing
            # inline errors easier later on.
            def phantoms_check():
                errs = self.panel.find_all_results_with_text()
                errs_by_file = {}
                for file, line, column, text in errs:
                    if file not in errs_by_file:
                        errs_by_file[file] = {}
                    if line not in errs_by_file[file]:
                        errs_by_file[file][line] = {}
                    errs_by_file[file][line][column] = text
                self.errs_by_file = errs_by_file
                self.update_phantoms()
                self.should_update_phantoms = False

            if not self.should_update_phantoms:
                if self.show_errors_inline and data.find("\n") >= 0:
                    self.should_update_phantoms = True
                    sublime.set_timeout(lambda: phantoms_check())

    def on_data(self, proc, data):
        if proc != self.proc:
            return
        self.write(None, data)

    def on_finished(self, proc):
        if proc != self.proc:
            return

        if proc.killed:
            self.write(None, "\n[Cancelled]")
        elif not self.quiet:
            elapsed = time.time() - proc.start_time
            if elapsed < 1:
                elapsed_str = "%.0fms" % (elapsed * 1000)
            else:
                elapsed_str = "%.1fs" % (elapsed)

            exit_code = proc.exit_code()
            if exit_code == 0 or exit_code is None:
                self.write(None, "[Finished in %s]" % elapsed_str)
            else:
                self.write(
                    None,
                    "[Finished in %s with exit code %d]\n" % (elapsed_str, exit_code),
                )

        if proc.killed:
            sublime.status_message("Build cancelled")
        else:
            with self.panel_lock:
                errs = self.panel.find_all_results()
                if len(errs) == 0:
                    sublime.status_message("Build finished")
                else:
                    sublime.status_message("Build finished with %d errors" % len(errs))

    def update_phantoms(self):
        stylesheet = """
            <style>
                div.error-arrow {
                    border-top: 0.4rem solid transparent;
                    border-left: 0.5rem solid color(var(--redish) blend(var(--background) 30%));
                    width: 0;
                    height: 0;
                }
                div.error {
                    padding: 0.4rem 0 0.4rem 0.7rem;
                    margin: 0 0 0.2rem;
                    border-radius: 0 0.2rem 0.2rem 0.2rem;
                }
                div.error span.message {
                    padding-right: 0.7rem;
                }
                div.error a {
                    text-decoration: inherit;
                    padding: 0.35rem 0.7rem 0.45rem 0.8rem;
                    position: relative;
                    bottom: 0.05rem;
                    border-radius: 0 0.2rem 0.2rem 0;
                    font-weight: bold;
                }
                html.dark div.error a {
                    background-color: #00000018;
                }
                html.light div.error a {
                    background-color: #ffffff18;
                }
            </style>
        """

        for file, err_lines in self.errs_by_file.items():
            view = self.window.find_open_file(file)
            if view:
                buffer_id = view.buffer_id()

                if buffer_id not in self.phantom_sets_by_buffer:
                    phantom_set = sublime.PhantomSet(view, "exec")
                    self.phantom_sets_by_buffer[buffer_id] = phantom_set
                else:
                    phantom_set = self.phantom_sets_by_buffer[buffer_id]

                phantoms = []

                for line, errs in err_lines.items():
                    for column, text in errs.items():
                        pt_a = view.text_point(line - 1, column - 1)
                        pt_b = pt_a + 1
                        if view.classify(pt_a) & sublime.CLASS_WORD_START:
                            pt_b = view.find_by_class(
                                pt_a, forward=True, classes=(sublime.CLASS_WORD_END)
                            )

                        if pt_b <= pt_a:
                            pt_b = pt_a + 1
                        elif view.classify(pt_b) & sublime.CLASS_LINE_END:
                            pt_b = pt_a

                        phantoms.append(
                            sublime.Phantom(
                                sublime.Region(pt_a, pt_b),
                                """<body id=inline-error>{}
                                <div class="error-arrow"></div><div class="error">
                                <span class="message">{}</span>
                                <a href="{}">{}</a></div><br>
                                </body>""".format(
                                    stylesheet,
                                    html.escape(text, quote=False),
                                    (line, column),
                                    chr(0x00D7),
                                ),
                                sublime.LAYOUT_BELOW,
                                on_navigate=self.hide_phantom,
                            )
                        )

                phantom_set.update(phantoms)

    def hide_all_phantoms(self):
        self.hide_view_phantoms()

        for window in sublime.windows():
            for file, errs in self.errs_by_file.items():
                view = window.find_open_file(file)
                if view:
                    view.erase_phantoms("exec")
                    view.erase_regions("exec")
                    view.hide_popup()

    def hide_view_phantoms(self):
        view = sublime.active_window().active_view()
        if view:
            view.erase_phantoms("exec")
            view.erase_regions("exec")
            view.hide_popup()
            if view.file_name() in self.errs_by_file:
                del self.errs_by_file[view.file_name()]
            if view.buffer_id() in self.phantom_sets_by_buffer:
                del self.phantom_sets_by_buffer[view.buffer_id()]

        self.show_errors_inline = False

    def hide_phantom(self, phantom_url):
        view = sublime.active_window().active_view()
        (line, column) = literal_eval(phantom_url)
        # since we can't run zig builds on unsaved files, this file should exist
        file = view.file_name()
        del self.errs_by_file[file][line][column]
        self.update_phantoms()


class Zig(sublime_plugin.EventListener):
    def on_load_async(self, view):
        w = view.window()
        if w is not None:
            w.run_command("zig_build", {"update_phantoms_only": True})

    def on_post_save_async(self, view):
        sel = view.sel()[0]
        region = view.word(sel)
        scope = view.scope_name(region.b)
        if scope.find("source.zig") != -1:
            should_fmt = get_setting(view, "zig.fmt.on_save", True)
            should_build = get_setting(view, "zig.build.on_save", False)
            is_quiet = get_setting(view, "zig.quiet", True)

            if should_fmt:
                mode = get_setting(view, "zig.fmt.mode", "file").lower()
                mode = "$file" if mode == "file" else "$folder"
                view.window().run_command(
                    "zig_build", {"cmd": ["fmt", mode], "quiet": True}
                )
            if should_build:
                view.window().run_command("zig_build", {"build": {}})
            if is_quiet:
                view.window().run_command("hide_panel")