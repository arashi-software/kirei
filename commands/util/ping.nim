## ping
## Return bot latency

cmd.addChat("ping") do ():
  var m: Message
  try:  
    let before = epochTime() * 1000
    m = await kirei.api.sendMessage(msg.channel_id, "Pong")
    let after = epochTime() * 1000
    discard await kirei.api.editMessage(msg.channelID, m.id, embeds = @[Embed(
      author: some EmbedAuthor(name: msg.author.username, icon_url: some msg.author.avatarUrl()),
      title: some "Pong 🏓",
      description: some "Message latency: $#ms\nServer latency: $#ms" % [$int(after - before), $s.latency()],
      color: some 0x6f93b6
    )])
  except CatchableError:
    discard await kirei.api.editMessage(msg.channelID, m.id, embeds = @[errEmbed(getCurrentExceptionMsg())])
