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
    echo "wip"
proc createSeqMusic(): seq[string] =
    result = toSeq(walkFiles(raw&"*.mp3"))
proc iterateSeq(list: seq[string]) = 
#    for i in range(list.count()):
#        list[i] = list[i].extractFilename()
    for file in list:
        echo file
        var tag = readId3(file)
        #for textFrame in tag.textFrames:
        #    echo fmt"id: {textFrame.id}"
        #    echo fmt"conent: {textFrame.content}"
        var artist: string = tag.textFrames[1][1]
        var album: string = tag.textFrames[2][1]
        var name: string = tag.textFrames[0][1]
        var trackNum: string = tag.textFrames[5][1]
        artist = artist.replace("/", "")
        album = album.replace("/","")
        name = name.replace("/", "")
        trackNum = trackNum.replace("/", "")
        createDir(sorted&artist)
        createDir(sorted&artist&"/"&album)
        let endName: string = trackNum&" "&name&".mp3"
        copyFile(file, sorted&artist&"/"&album&"/"&endName)

when isMainModule:
    moveMusicToRaw()
    var list: seq[string] = createSeqMusic()
    echo list
    iterateSeq(list)


