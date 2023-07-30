proc onReady(s: Shard, r: Ready) {.event(kirei).} =
  echo fmt"Logged in as {r.user.username}#{r.user.discriminator} ({r.user.id})"
