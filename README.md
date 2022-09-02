Zig Language
============

Syntax highlighting for [Zig](http://ziglang.org/)
for [Sublime Text](sublimetext.com/) editor.
Use [Package control](https://packagecontrol.io) to install this.

The two syntaxes
----------------

Sublime Text 3 and above uses the `.sublime-syntax` file.
This is the one you should edit to improve Sublime Text support.
See [official docs](http://www.sublimetext.com/docs/3/syntax.html)

This repository also contains a `.tmLanguage` syntax for old versions of Sublime Text or TextMate.
This file is also used by **Github's syntax highlighting**:
[Github Linguist](https://github.com/github/linguist).


Sublime text Installation
-----------

Use [Package control](https://packagecontrol.io) to install this.


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

LICENSE
-------

Provided under an MIT License
