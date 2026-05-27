require "json"
module Evt::InteractionCreate
  def self.run(cli,payload)
    data=JSON.parse(payload.to_s)
    if data["type"]?==2
      if inner=data["data"]?
        name=inner["name"]?
        Cmds.all.each{|cmd|if name==cmd.name;cmd.run(cli,data);break;end}
      end
    elsif data["type"]?==3
      id=data["data"]["custom_id"].as_s
      if id.starts_with?("custom_")
        app=data["application_id"].as_s
        tok=data["token"].as_s
        cli.req("POST","/interactions/#{data["id"]}/#{tok}/callback",{"type"=>5})
        parts=id.split("_")
        msg=parts[3]
        amt=parts[4].to_i
        amt.times{cli.req("POST","/webhooks/#{app}/#{tok}",{"content"=>msg});sleep(0.5.seconds)}
      end
    end
  rescue ex
    puts "Evt: #{ex.message}"
  end end