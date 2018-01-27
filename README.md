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

Use [Package control](https://packagecontrol.io) or add `Zig.tmLanguage` to the
packages directory.

On OSX This is usually:

```
~/Library/Application\ Support/Sublime\ Text\ 3/Packages/
```

...but to find the path on your machine go to `Preferences > Browse Packages` from
within Sublime Text.


LICENSE
-------

Provided here under an MIT License
