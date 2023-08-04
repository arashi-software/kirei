import std/[macros, strutils, os]

macro importAll*(path: static string, parent: static bool = false): untyped =
  var bracket = newNimNode(nnkBracket)
  for x in walkDirRec(path):
      let split = x.splitFile()
      if split.ext == ".nim":
        if parent:
          let s = split.dir.split("/")
          bracket.add ident(s[s.len - 1] / split.name)
        else:
          bracket.add ident(split.name)
  newStmtList(
    newNimNode(nnkIncludeStmt).add(
      newNimNode(nnkInfix).add(
        ident("/"),
        newNimNode(nnkPrefix).add(
          ident("../"),
          ident(path)
        ),
        bracket
      )
    )
  )