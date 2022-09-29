# Package

version       = "0.1.0"
author        = "Yamato Security @SecurityYamato"
description   = "Takajo is Hayabusa output analyzer."
license       = "MIT"
srcDir        = "src"
installExt    = @["nim"]
bin           = @["takajo"]


# Dependencies

requires "nim >= 1.6.6"
requires "docopt >= 0.6"
