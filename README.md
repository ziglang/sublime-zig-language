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

Local Development
-----------------

Install https://github.com/SublimeText/PackageDev.

Edit the YAML entry and use the `Convert (YAML, JSON, PList) to...` command
to generate the other entries.

Copy the generated file to your local sublime text folder. e.g.

```
cp Zig.tmLanguage "/Users/jfo/Library/Application Support/Sublime Text 3/Packages/User/Zig.tmLanguage"
```

On linux, this is located under `~/.config/sublime-text-3/`.

LICENSE
-------

Provided under an MIT License
