# Package

version       = "1.0.0"
author        = "Yamato Security @SecurityYamato"
description   = "Takajo is Hayabusa output analyzer."
license       = "GPL-3.0"
srcDir        = "src"
installExt    = @["nim"]
bin           = @["takajo"]


# Dependencies

requires "nim >= 1.6.6"
requires "cligen >= 1.5"
