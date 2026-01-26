# Package

version       = "2.16.0"
author        = "Yamato Security @SecurityYamato"
description   = "Takajo is an analyzer for Hayabusa results."
license       = "AGPL-3.0"
srcDir        = "src"
installExt    = @["nim"]
bin           = @["takajo"]


# Dependencies
requires "nim >= 2.2.4"
requires "cligen >= 1.7.6"
requires "suru#f6f1e607c585b2bc2f71309996643f0555ff6349"
requires "puppy >= 2.1.0"
requires "termstyle"
requires "nancy"
requires "malebolgia >= 1.3.2"
requires "jsony >= 1.1.5"
requires "db_connector >= 0.1.0"
requires "prologue"
