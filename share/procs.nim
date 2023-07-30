import strutils

proc getCommandInfo(filename: string): tuple[usage: string, desc: string] = 
  var lines = readLines(filename, 2).splitLines()
  return (usage: lines[0].replace("## ", ""), desc: lines[1].replace("## ", ""))
