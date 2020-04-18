import sublime
import sublime_plugin

settings = sublime.load_settings('Zig.sublime-settings')


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