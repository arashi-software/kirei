## help <?cmd>
## Show all commands or info on a specific command

cmd.addChat("help") do (cmd: Option[string]):
  if not cmd.isSome():
    var opts: seq[SelectMenuOption]
    for file in walkDir("commands", relative = true):
      if file.kind == pcDir:
        opts.add(newMenuOption(file.path.capitalizeAscii(), file.path))
    var row = newActionRow()
    row &= newSelectMenu("helpSlm", opts, placeholder = "Select a category")
    hmid = await kirei.api.sendMessage(msg.channelID, embeds = @[Embed(
      author: some EmbedAuthor(name: msg.author.username, icon_url: some msg.author.avatarUrl()),
      title: some "Kirei Commands",
      description: some "Select a category to view commands",
      color: some 0x6f93b6
    )], components = @[row])
  else:
    var valid: Option[Message]
    for file in walkDirRec("commands"):
      let x = file.splitFile()
      if x.name == cmd.get():
        let cmdinfo = getCommandInfo(file)
        valid = some await kirei.api.sendMessage(msg.channelID, embeds = @[Embed(
          author: some EmbedAuthor(name: msg.author.username, icon_url: some msg.author.avatarUrl()),
          title: some cmdinfo.usage,
          description: some cmdinfo.desc,
          color: some 0x6f93b6
        )])
    if valid.isNone():
      discard await kirei.api.sendMessage(msg.channelID, embeds = @[errEmbed("That command does not exist")])
