# Sparrow Wallet AppImage
:warning: _This is an unofficial AppImage of Sparrow Wallet._

Provides a script that will build an AppImage of [Sparrow Wallet](https://github.com/sparrowwallet/sparrow).

It will temporarily download and run `appimagetool` against the set version of Sparrow,
building an AppImage that can be found in `~/Documents`.

### Why an AppImage? Sparrow is pretty much a a standalone binary.
Why? Because I wanted to? I prefer it over running it out of an extracted tar file.

AppImages provides the ability to set custom `.config` and `$HOME` directories.
This allows for isolated settings/configs/caches to exist in their own place without
cluttering up you main `$HOME`.

But Sparrow has the `-d` option that can specify a custom directory!

Well that means one has to launch Sparrow from the cli or create a custom launcher with those arguments. Might as well just package it up with the arguments made.

### NOTES
Sparrow.AppImage does NOT respect _Sparrow.AppImage.config_ as it does not use the _.config_ directory.

By default Sparrow seems to be hard coded to use _/home/$USER/.sparrow_ and not _$HOME/.sparrow_, 
I suspect, I haven't checked the actual code. It just came up in testing.
In order to respect _$HOME_, `-d $HOME/.sparrow` is passed to Sparrow in the AppRun.
This allows for _/home/$USER/.sparrow_ & _Sparrow.AppImage.home/.sparrow_ to be used.
If you want to store _Sparrow.AppImage.home/.sparrow_ somewhere else just symlink the directory.
