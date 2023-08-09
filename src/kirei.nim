import std/[os, asyncdispatch, strformat, options, strutils, times, macros, random]
import dotenv; load()
import imports
import dimscord,
       dimscmd,
       limdb,
       flatty,
       jsony,
       puppy

let kirei = newDiscordClient(getEnv("TOKEN"))
var cmd = kirei.newHandler()
let db = initDatabase("db", (snipe: string))
var hmid: Message

# Import all shared components
importAll("share")

# Register all events
importAll("events")

# Register all message commands
importAll("commands", true)

waitFor kirei.startSession() 
