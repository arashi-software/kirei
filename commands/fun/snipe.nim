## snipe
## Get the last deleted message in the server

cmd.addChat("snipe") do ():
  try:
    if db.snipe.hasKey(msg.guild_id.get()):
      let snipeMsg = db.snipe[msg.guild_id.get()].fromFlatty(SnipeMessage)
      discard await kirei.api.sendMessage(msg.channelID, embeds = @[Embed(
       timestamp: some snipeMsg.timestamp, 
       author: some EmbedAuthor(name: "Sent by $#" % [snipeMsg.authorName], icon_url: some snipeMsg.authorPfp),
       description: some snipeMsg.content,
       color: some 0x6f93b6
       )])
    else:
      discard await kirei.api.sendMessage(msg.channelID, embeds = @[errEmbed("No deleted messages found")]) 
  except CatchableError:
    discard await kirei.api.sendMessage(msg.channelID, embeds = @[errEmbed(getCurrentExceptionMsg())])
