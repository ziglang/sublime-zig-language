import sublime
import sublime_plugin

import subprocess
import threading
import os

settings = sublime.load_settings('Zig.sublime-settings')
preferences_settings = sublime.load_settings("Preferences.sublime-settings")

def get_setting(view, opt, default):
    return view.settings().get(opt, settings.get(opt, default))

class Zig(sublime_plugin.EventListener):
    def on_post_save_async(self, view):
        sel = view.sel()[0]
        region = view.word(sel)
        scope = view.scope_name(region.b)
        if scope.find('source.zig') != -1:
            should_fmt = get_setting(view, 'zig.fmt.on_save', True)
            should_build = get_setting(view, 'zig.build.on_save', False)
            is_quiet = get_setting(view, 'zig.quiet', True)
            
            if (should_fmt):
                mode = get_setting(view, 'zig.fmt.mode', 'File').title()
                view.window().run_command('build', {'variant': 'Format ' + mode})
            if (should_build):
                view.window().run_command('build')
            if (is_quiet):
                view.window().run_command("hide_panel")

class ZigBuildCommand(sublime_plugin.WindowCommand):
    encoding = 'utf-8'
    killed = False
    proc = None
    panel = None
    panel_lock = threading.Lock()

    def is_enabled(self, cmd=None, build=None, quiet=False, kill=False):
        # The Cancel build option should only be available
        # when the process is still running
        if kill:
            return self.proc is not None and self.proc.poll() is None
        return True

    def run(self, cmd=None, build=None, quiet=False, kill=False):
        if kill:
            if self.proc:
                self.killed = True
                self.proc.terminate()
            return

        vars = self.window.extract_variables()
        working_dir = vars.get('file_path', vars['folder'])

        view = self.window.active_view()
        is_quiet = get_setting(view, 'zig.quiet', quiet)

        # A lock is used to ensure only one thread is
        # touching the output panel at a time
        with self.panel_lock:
            # Creating the panel implicitly clears any previous contents
            self.panel = self.window.create_output_panel('exec')

            # Enable result navigation. The result_file_regex does
            # the primary matching, but result_line_regex is used
            # when build output includes some entries that only
            # contain line/column info beneath a previous line
            # listing the file info. The result_base_dir sets the
            # path to resolve relative file names against.
            settings = self.panel.settings()
            settings.set(
                'result_file_regex',
                r'^(?:.\/)(\S.*):(\d*):(\d*): (?:[^:]*): (.*)$'
            )
            settings.set(
                'result_line_regex',
                r'^(?:\S.*):(\d*):(\d*): (?:[^:]*): (.*)$'
            )
            settings.set('result_base_dir', working_dir)
            self.window.create_output_panel('exec')

            if not is_quiet:
                self.window.run_command('show_panel', {'panel': 'output.exec'})

        if self.proc is not None:
            self.proc.terminate()
            self.proc = None

        args = [get_setting(view, 'zig.executable', 'zig')]

        if build is not None and cmd is None:
            args.append('build')

            if isinstance(build, dict):
                step = build.get('step', '')
                step_args = build.get('args', [])
                if step != '': args.append(step)
                if step_args != []:
                    args.append('--')
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

        args = sublime.expand_variables(args, vars)

        self.proc = subprocess.Popen(
            args,
            stdout=subprocess.PIPE,
            stderr=subprocess.STDOUT,
            cwd=working_dir
        )
        self.killed = False

        threading.Thread(
            target=self.read_handle,
            args=(self.proc.stdout,)
        ).start()

    def read_handle(self, handle):
        chunk_size = 2 ** 13
        out = b''
        while True:
            try:
                data = os.read(handle.fileno(), chunk_size)
                # If exactly the requested number of bytes was
                # read, there may be more data, and the current
                # data may contain part of a multibyte char
                out += data
                if len(data) == chunk_size:
                    continue
                if data == b'' and out == b'':
                    raise IOError('EOF')
                # We pass out to a function to ensure the
                # timeout gets the value of out right now,
                # rather than a future (mutated) version
                self.queue_write(out.decode(self.encoding))
                if data == b'':
                    raise IOError('EOF')
                out = b''
            except (UnicodeDecodeError) as e:
                msg = 'Error decoding output using %s - %s'
                self.queue_write(msg  % (self.encoding, str(e)))
                break
            except (IOError):
                if self.killed:
                    msg = 'Cancelled'
                else:
                    msg = 'Finished'
                self.queue_write('\n[%s]' % msg)
                break

    def queue_write(self, text):
        sublime.set_timeout(lambda: self.do_write(text), 1)

    def do_write(self, text):
        with self.panel_lock:
            self.panel.run_command('append', {'characters': text})
