[Zig](http://ziglang.org/) syntax highlighting for [Sublime Text](sublimetext.com/).
==

Note: This is *not* the official package. That is [here](https://github.com/ziglang/sublime-zig-language). When I first made this repo, it was unmaintained. I think that Zig should have first class support in Sublime Text, so I'm starting here.

Auto-install (unavailable currently)
------------

Use [Package Control](https://packagecontrol.io) to install this.

Manually
--------
Add `Zig.sublime-syntax` and `Zon.sublime-syntax` to the packages directory. On MacOS this is usually

```
~/Library/Application\ Support/Sublime\ Text/
```

Otherwise use `Preferences > Browse Packages` from within Sublime Text.


Local Development
-----------------

Clone or copy this repository to your local Sublime Text folder. e.g.

```
git clone https://github.com/ziglang/sublime-zig-language.git "/Users/$USER/Library/Application Support/Sublime\ Text/Packages/Zig Language"
```

For working on ST3+ support, you can edit the `.sublime-syntax` directly.
But installing [PackageDev](https://packagecontrol.io/packages/PackageDev)
will provide some syntax highlighting.
You can run the tests in [syntax_test.zig](./Syntaxes/syntax_test.zig)
with the "Syntax Tests" builtin build system.
Sublime Text will automatically reload the syntax on save.
If you have a big Zig project open this can make your CPU spin while Sublime reindexes everything.

Build System
------------

The included Sublime Text build system comes with a few options for configuration and defining your own build targets. See [here](build.md) for more information.
