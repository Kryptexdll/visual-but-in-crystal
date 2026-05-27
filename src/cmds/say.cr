require "json"
module Cmds::Say
  def self.name; "say"; end
  def self.description; "say something"; end
  def self.options
    [{"name"=>"message","description"=>"message to send","type"=>3,"required"=>true}]
  end
  def self.run(cli,inter)
    id=inter["id"].as_s
    tok=inter["token"].as_s
    app=inter["application_id"].as_s
    data=inter["data"]
    msg=data["options"]?.try(&.[0]["value"].as_s)||"no message provided."
    init={"type"=>4,"data"=>{"content"=>"This bot was originally created by Kryptex (1456103931993264294). Need help? Join discord.gg/heyho","flags"=>64}}
    cli.req("POST","/interactions/#{id}/#{tok}/callback",init)
    followup={"content"=>msg}
    cli.req("POST","/webhooks/#{app}/#{tok}",followup)
  rescue ex
    puts "/say: #{ex.message}"
  end end