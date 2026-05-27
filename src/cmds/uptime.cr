require"http/headers"
require"json"
require"../com/emb"
module Cmds::Uptime
  def self.name : String "uptime" end
  def self.description : String "display bot uptime" end
  def self.run(cli,inter)
    id=inter["id"].as_s
    tok=inter["token"].as_s
    app=inter["application_id"].as_s
    diff=Time.utc-Start
    d=diff.days
    h=diff.hours
    m=diff.minutes
    s=diff.seconds
    emb=Com::Embed.new.title("bot uptime").color(0x10e1fe).timestamp.build
    emb["description"]=JSON::Any.new("**Uptime:** #{d}d #{h}h #{m}m #{s}s")
    cli.req("POST","/interactions/#{id}/#{tok}/callback",{"type"=>4,"data"=>{"embeds"=>[emb]}})
  rescue ex
    puts "#{ex.message}"
  end end