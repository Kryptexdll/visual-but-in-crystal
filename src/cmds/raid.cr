require "json"
require "../com/emb"
module Cmds::Raid
  def self.name; "raid"; end
  def self.description; "raid a channel"; end
  def self.options
    [{"name"=>"message","description"=>"the message","type"=>3,"required"=>true},
     {"name"=>"amount","description"=>"amount (1-5)","type"=>4,"required"=>false,"min_value"=>1,"max_value"=>5}]
  end
  def self.run(cli,inter)
    id=inter["id"].as_s
    tok=inter["token"].as_s
    app=inter["application_id"].as_s
    user=inter["member"]["user"]["id"].as_s
    datenow=Time.utc.to_s("%Y-%m-%d")
    opts=inter["data"]["options"].as_a
    msg=opts.find{|o|o["name"].as_s=="message"}.try(&.["value"].as_s)||"Default"
    amt=opts.find{|o|o["name"].as_s=="amount"}.try(&.["value"].as_i)||5
    emb=Com::Embed.new.title("Visual But in Crystal").color(0x10e1fe).timestamp.build
    emb["description"]=JSON::Any.new("Msg: #{msg}\nAmount: #{amt}\n-# This bot was originally created by Kryptex (1456103931993264294). Need help? Join discord.gg/heyho")
    comp={"type"=>1,"components"=>[{"type"=>2,"style"=>1,"label"=>"Execute","custom_id"=>"custom_#{user}_#{datenow}_#{msg}_#{amt}"}]}
    cli.req("POST","/interactions/#{id}/#{tok}/callback",{"type"=>4,"data"=>{"embeds"=>[emb],"components"=>[comp],"flags"=>64}})
  rescue ex
    puts "/raid: #{ex.message}"
  end end