# Package

version       = "2.1.0"
author        = "Yamato Security @SecurityYamato"
description   = "Takajo is an analyzer for Hayabusa results."
license       = "GPL-3.0"
srcDir        = "src"
installExt    = @["nim"]
bin           = @["takajo"]


# Dependencies

requires "nim >= 1.6.12"
requires "cligen >= 1.5"
requires "suru#f6f1e607c585b2bc2f71309996643f0555ff6349"
requires "puppy >= 2.1.0"
requires "termstyle"
requires "nancy"