import sublime
import sublime_plugin

def fmt(fmt, dic):
  for k in dic:
    fmt = fmt.replace("{" + k + "}", str(dic[k]))
  return fmt

class Zig(sublime_plugin.EventListener):
    def on_post_save(self, view):
        global_settings = sublime.load_settings(fmt("{package}.sublime-settings", {
            "package": self.__class__.__name__,
        }))
        should_fmt = view.settings().get('fmt.on_save.enabled', global_settings.get('fmt.on_save.enabled'))
        if (should_fmt):
            view.window().run_command("build", {"variant": "Format File"})
