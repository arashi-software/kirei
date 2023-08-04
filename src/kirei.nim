import std/[os, asyncdispatch, strformat, options, strutils, times, macros, random]
import dotenv; load()
import imports
import dimscord,
       dimscmd,
       limdb,
       flatty

let kirei = newDiscordClient(getEnv("TOKEN"))
var cmd = kirei.newHandler()
let db = initDatabase("db", (snipe: string))
var hmid: Message

# Import all shared components
importAll("share")

# Register all events
importAll("events")

# Register all message commands
importAll("commands", true)

cmd.addChat("gamble") do (user1: User, user2: Option[User]):
  try:
    randomize()
    var users = @[user1]
    if user2.isNone(): users.add(msg.author)
    else: users.add(user2.get())
    let winner = sample(users)
    discard await kirei.api.sendMessage(msg.channelID, embeds = @[Embed(
      author: some EmbedAuthor(name: msg.author.username, icon_url: some msg.author.avatarUrl()),
      title: some "The winner is $#" % [winner.username],
      color: some 0x6f93b6
    )])
  except CatchableError:
    discard await kirei.api.sendMessage(msg.channelID, embeds = @[errEmbed(getCurrentExceptionMsg())])

waitFor kirei.startSession() 
