# This is just an example to get you started. A typical binary package
# uses this file as the main entry point of the application.
import metatag/id3
import os
import std/sequtils
import std/strutils

const raw: string = "raw/"
const sorted: string = "sorted/"
const version:string = "DEVELOPMENT"

proc moveMusicToRaw() =
    createDir(raw)
    createDir(sorted)
proc createSeqMusic(): seq[string] =
    result = toSeq(walkFiles(raw&"*.mp3"))
proc iterateSeq(list: seq[string]) = 
    for file in list:
        var tag = readId3(file)
        var artist: string = tag.textFrames[1][1]
        var album: string = tag.textFrames[2][1]
        var name: string = tag.textFrames[0][1]
        var trackNum: string = tag.textFrames[5][1]
        # Whenever there is a / in the metadata it reads as a \0 which doesn't appear in echo and causes issues with createDir
        artist = artist.replace("/", "-").replace(" ", "_").replace("\0", "-")
        album = album.replace("/","").replace("\0", "-")
        name = name.replace("/", "").replace("\0", "-")
        trackNum = trackNum.replace("/", "")

        let artistDir: string = sorted&artist
        let albumDir: string = artistDir&"/"&album

        createDir(albumDir)

        let endName: string = trackNum&" "&name&".mp3"
        copyFile(file, albumDir&"/"&endName)

when isMainModule:
    moveMusicToRaw()
    var list: seq[string] = createSeqMusic()
    iterateSeq(list)


