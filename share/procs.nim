proc getCommandInfo(filename: string): tuple[usage: string, desc: string] = 
  var lines = readFile(filename).splitLines()
  return (usage: lines[0].replace("## ", ""), desc: lines[1].replace("## ", ""))
