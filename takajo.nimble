# Package

version       = "2.0.0"
author        = "Yamato Security @SecurityYamato"
description   = "Takajo is an analyzer for Hayabusa results."
license       = "GPL-3.0"
srcDir        = "src"
installExt    = @["nim"]
bin           = @["takajo"]


# Dependencies

requires "nim >= 1.6.12"
requires "cligen >= 1.5"
requires "progress >= 1.1.3"
requires "terminaltables"