import std/[os, asyncdispatch, strformat, options, strutils, times]
import dotenv; load()
import dimscord,
       dimscmd,
       limdb,
       flatty

type
  SnipeMessage = object
    authorName: string
    authorPfp: string
    timestamp: string
    content: string
  

let kirei = newDiscordClient(getEnv("TOKEN"))
var cmd = kirei.newHandler()
let db = initDatabase("db", (snipe: string))

# Import all shared components
include ../share/[
  embeds,
  procs
]

# Register all events
include ../events/[
  ready,
  msgcreate,
  msgdelete
]

# Register all message commands
include ../commands/fun/[
  snipe
]

include ../commands/util/[
  ping,
  help
]

cmd.addChat("help") do (cmd: Option[string]):
  if not cmd.isSome():
    var opts: seq[SelectMenuOption]
    for file in walkDir("commands", relative = true):
      if file.kind == pcDir:
        opts.add(newMenuOption(file.path.capitalizeAscii(), file.path))
    var row = newActionRow()
    row &= newSelectMenu("helpSlm", opts, placeholder = "Select a category")
    discard await kirei.api.sendMessage(msg.channelID, embeds = @[Embed(
      author: some EmbedAuthor(name: msg.author.username, icon_url: some msg.author.avatarUrl()),
      title: some "Kirei Commands",
      description: some "Select a category to view commands",
      color: some 0x6f93b6
    )], components = @[row])    


waitFor kirei.startSession() 
