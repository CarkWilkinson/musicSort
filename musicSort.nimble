# Package

version       = "0.0.0"
author        = "Mark Wilkinson"
description   = "A tool to sort your mp3 music files based on id3 metadata"
license       = "MIT"
srcDir        = "src"
bin           = @["musicSort"]


# Dependencies

requires "nim >= 1.6.10"
requires "metatag"
