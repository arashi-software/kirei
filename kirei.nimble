# Package

version       = "0.1.0"
author        = "Luke"
description   = "A multipurpose discord bot written in nim"
license       = "GPL-3.0-or-later"
srcDir        = "src"
binDir        = "bin"
bin           = @["kirei"]


# Dependencies

requires "nim >= 1.4.8", "dimscord", "dimscmd", "limdb", "flatty", "dotenv"
