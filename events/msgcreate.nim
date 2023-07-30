proc messageCreate (s: Shard, msg: Message) {.event(kirei).} =
  discard await cmd.handleMessage(@["k!", "rei", "Rei", "kirei", "Kirei"], s, msg)
