require"../lib/discordcr/src/discordcr"
require"./client/msgha"
require"./client/client"
require"./cmds/*"
require"./evt/*"
bot=Client::Bot.new
cli=bot.cli
Start=Time.utc
cli.on_ready do|p|
  Evt::Ready.run(cli,p)
  bot.load(Cmds.all) end
cli.on_dispatch do|evt,payload|
  if evt=="INTERACTION_CREATE"
    Evt::InteractionCreate.run(cli,payload)
  end end
cli.run