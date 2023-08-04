proc messageDelete(s: Shard, m: Message, exists: bool) {.event(kirei).} =
  if not m.author.bot:
    var gid = get m.guild_id
    db.snipe[gid] = toFlatty SnipeMessage(
      authorName: m.author.username,
      authorPfp: m.author.avatarUrl(),
      content: m.content,
      timestamp: m.timestamp 
    )
