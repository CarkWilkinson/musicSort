import metatag/id3
import os
import std/sequtils

const raw: string = "raw/"
const sorted: string = "sorted/"
const version:string = "0.1.0"

proc moveMusicToRaw() =
    createDir(raw)
    createDir(sorted)

proc createSeqMusic(): seq[string] =
    result = toSeq(walkFiles(raw&"*.mp3"))

proc iterateSeq(list: seq[string]) = 
    for file in list:
        var tag = readId3(file)
        let artist: string = tag.textFrames[1][1]
        let album: string = tag.textFrames[2][1]
        createDir(sorted&artist)
        createDir(sorted&artist&"/"&album)
        let endName: string = tag.textFrames[5][1]&" "&tag.textFrames[0][1]&".mp3"
        copyFile(file, sorted&artist&"/"&album&"/"&endName)

when isMainModule:
    moveMusicToRaw()
    var list: seq[string] = createSeqMusic()
    iterateSeq(list)


