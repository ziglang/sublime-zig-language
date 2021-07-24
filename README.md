Zig Language
============

Syntax highlighting for [Zig](http://ziglang.org/).

This repository serves both as the grammar for
[github/linguist](https://github.com/github/linguist) (Github's site wide
syntax highlighting) and as a standalone Sublime Text package.

The source of truth is `Zig.YAML-tmLanguage`. This file is read by linguist
directly and used as the source to compile to `Zig.tmLanguage` using
[PackageDev](https://github.com/SublimeText/PackageDev) from within Sublime. Do
not edit `Zig.tmLanguage` directly.

Installation
-----------

Use [Package control](https://packagecontrol.io).

Or add `Zig.tmLanguage` to the packages directory. On OSX This is usually

```
~/Library/Application\ Support/Sublime\ Text\ 3/Packages/
```

But to find the path on your machine go to `Preferences > Browse Packages` from
within Sublime Text.

TextMate Installation
---------------------

This language is also compatible with TextMate's `.tmBundle` format. To install in TextMate clone or download this repository. Then rename the repository directory to `Zig.tmBundle` and double-click it to install it into TextMate. However, see [Zig.tmbundle](https://github.com/ziglang/Zig.tmbundle) for dedicated TextMate support.

Local Development
-----------------

Install https://github.com/SublimeText/PackageDev.

Clone or copy this repository to your local Sublime Text folder. e.g.

```
git clone https://github.com/ziglang/sublime-zig-language.git "/Users/$USER/Library/Application Support/Sublime Text 3/Packages/Zig Language"
```

Edit the YAML entry and use the `Convert (YAML, JSON, PList) to...` command
to generate the other entries. Sublime Text will automatically reload the plugin, showing changes in the build system, syntax highlighting, etc.


On Linux, this is located under `~/.config/sublime-text-3/`.

Build System
------------

The included Sublime Text build system comes with a few options for configuration and defining your own build targets. See [here](build.md) for more information.

LICENSE
-------

Provided under an MIT License
