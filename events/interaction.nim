proc interactionCreate(s: Shard, i: Interaction) {.event(kirei).} =
  var data = i.data.get
  if data.custom_id == "helpSlm":
    let category = data.values[0]
    var cmds: seq[string]
    for file in walkDir("commands" / category, relative = true):
      if file.kind == pcFile:
        let x = file.path.splitFile()
        cmds.add(x.name)
    discard await kirei.api.editMessage(i.channel_id.get(), hmid.id, embeds = @[Embed(
      author: some EmbedAuthor(name: i.member.get().user.username, icon_url: some i.member.get().user.avatarUrl()),
      title: some category.capitalizeAscii(),
      description: some cmds.join("\n"),
      color: some 0x6f93b6
    )], components = @[])
    #let deferData = InteractionResponse(
    #  kind: irtDeferredChannelMessageWithSource,
    #  data: some InteractionApplicationCommandCallbackData(flags: {})
    #)
    #await kirei.api.createInteractionResponse(i.id, i.token, deferData)