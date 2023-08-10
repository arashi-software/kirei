## gamble <user1> <?user2>
## Gamble with a user and show the winner

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