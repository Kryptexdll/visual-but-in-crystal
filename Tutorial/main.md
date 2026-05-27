# Visual Setup

This documentation covers the visual bot setup, including: commands, and handling.

## Main

the execution loads the client, registers events and loads commands.



- open data/bot/b.yaml and you should see that:
```yaml
token: "" 
global: false
guild_id: ""
```
> - The "token" is Your bots Token
> - If global false: register commands to the Guild "guild_id"
> - If global true: register Global Commands, Including DMS
> - The "guild_id" is your Config Guild

after you set all Configs, Open your Terminal then go into The folder's Path and run
```yaml
crystal run src/main.cr --error-trace
```
if you get errors run
```yaml
crystal run src/main.cr --error-trace
```