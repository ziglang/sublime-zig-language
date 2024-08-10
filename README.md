Zig Language (unofficial fork)
============

Note: I noticed that [http://github.com/ziglang/sublime-zig-language](http://github.com/ziglang/sublime-zig-language)
was unmaintained - I'm trying to make a fork to maintain with the hope of upstreaming over time.

Syntax highlighting for [Zig](http://ziglang.org/)
for [Sublime Text](sublimetext.com/) editor.
Use [Package control](https://packagecontrol.io) to install this.

Or add `Zig.tmLanguage` to the packages directory. On OSX This is usually

```
~/Library/Application\ Support/Sublime\ Text/
```

But to find the path on your machine go to `Preferences > Browse Packages` from
within Sublime Text.
=======

TextMate Installation
---------------------

The `Zig.tmLanguage` is also compatible with TextMate.
To install in TextMate clone or download this repository.
Then rename the repository directory to `Zig.tmBundle` and double-click it to install it into TextMate.
However, see [Zig.tmbundle](https://github.com/ziglang/Zig.tmbundle) for dedicated TextMate support.

Local Development
-----------------

Clone or copy this repository to your local Sublime Text folder. e.g.

```
git clone https://github.com/ziglang/sublime-zig-language.git "/Users/$USER/Library/Application Support/Sublime Text 3/Packages/Zig Language"
```

For working on ST3+ support, you can edit the `.sublime-syntax` directly.
But installing [PackageDev](https://packagecontrol.io/packages/PackageDev)
will provide some syntax highlighting.
You can run the tests in [syntax_test.zig](./Syntaxes/syntax_test.zig)
with the "Syntax Tests" builtin build system.
Sublime Text will automatically reload the syntax on save.
If you have a big Zig project open this can make your CPU spin while Sublime reindex everything.


For working on the old `.tmLanguage` syntax, work on the `Zig.YAML-tmLanguage` file.
**Important** Github Linguist's source of truth is `Zig.YAML-tmLanguage`.
Work on `Zig.YAML-tmLanguage` the use PackageDev command: `Convert (YAML, JSON, PList) to...`
to generate the `.tmLanguage`.
Sublime Text should also automatically reload the plugin, but doesn't have unit tests for `tmLanguage`.


Build System
------------

The included Sublime Text build system comes with a few options for configuration and defining your own build targets. See [here](build.md) for more information.
