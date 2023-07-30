proc errEmbed(error: string): Embed =
  Embed(
    title: some "Error ⭕",
    description: some error,
    color: some 0xe05f65
  )
