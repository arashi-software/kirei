type
  CHJpg = object
    imageUrl: string
  CHImages = object
    jpg: CHJpg
  CHData = object
    name: string
    nameKanji: string
    images: CHImages 
  CHJson = object
    data: CHData 

cmd.addChat("kmk") do ():
  try:
    let ch = fetch("https://api.jikan.moe/v4/random/characters").fromJson(CHJson)
    let reactions = @["💋", "💍", "🔪"]
    let m = await kirei.api.sendMessage(msg.channelID, embeds = @[Embed(
      author: some EmbedAuthor(name: msg.author.username, icon_url: some msg.author.avatarUrl()),
      title: some "$# ($#)" % [ch.data.name, ch.data.nameKanji],
      image: some EmbedImage(url: ch.data.images.jpg.imageUrl),
      color: some 0x6f93b6
    )])
    for r in reactions:
      await kirei.api.addMessageReaction(msg.channelID, m.id, r)
  except CatchableError:
    discard await kirei.api.sendMessage(msg.channelID, embeds = @[errEmbed(getCurrentExceptionMsg())])
