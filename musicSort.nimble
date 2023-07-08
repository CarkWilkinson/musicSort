# Package

version       = "0.1.0"
author        = "Mark Wilkinson"
description   = "A tool to sort mp3 music files based on ID3 metadata"
license       = "MIT"
srcDir        = "src"
bin           = @["musicSort"]


# Dependencies

requires "nim >= 1.6.10"
requires "metatag"
