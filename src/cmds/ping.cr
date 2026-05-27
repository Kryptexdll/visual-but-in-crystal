require"http/headers"
require"json"
require"../com/emb"
module Cmds::Ping
  def self.name : String"latency" end
  def self.description : String"display bot latency" end
  def self.run(cli,inter)
    id=inter["id"].as_s
    tok=inter["token"].as_s
    app=inter["application_id"].as_s
    d_time=(id.to_u64>>22)+1420070400000_u64
    ws=(Time.utc.to_unix_ms-d_time).to_i
    t1=Time.utc
    init={"type"=>4,"data"=>{"content"=>"loading albert brain fr"}}
    cli.req("POST","/interactions/#{id}/#{tok}/callback",init)
    api=(Time.utc-t1).total_milliseconds.round.to_i
    t2=Time.utc
    emb=Com::Embed.new.title("bot latency").color(0x10e1fe).timestamp.build
    emb["description"]=JSON::Any.new("**WebSocket Latency:** #{ws}ms\n**API Latency:** #{api}ms\n**Edit Latency:** loading")
    cli.edit_inter(app,tok,{"embeds"=>[emb],"content"=>""})
    edit=(Time.utc-t2).total_milliseconds.round.to_i
    emb["description"]=JSON::Any.new("**WebSocket Latency:** #{ws}ms\n**API Latency:** #{api}ms\n**Edit Latency:** #{edit}ms")
    cli.edit_inter(app,tok,{"embeds"=>[emb],"content"=>""})
  rescue ex
    puts "#{ex.message}"
  end
end