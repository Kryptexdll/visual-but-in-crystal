require "yaml"
require "json"
require "base64"
require "http/headers"
module Client
  class Bot
    property cli : Discord::Client
    property cfg : YAML::Any
    def initialize
      @cfg=YAML.parse(File.read("./data/bot/b.yaml"))
      tok=@cfg["token"].as_s
      @cli=Discord::Client.new(token:"Bot #{tok}")
    end
    def load(cmds)
      tok=@cfg["token"].as_s
      b64=tok.split(".")[0]
      app_id=String.new(Base64.decode(b64))
      g_id=@cfg["guild_id"]?.try(&.as_s?)
      is_global=@cfg["global"]?.try(&.as_bool?)||false
      payloads=cmds.map do |cmd|
        payload={} of String=>String|Int32|Array(Hash(String,String|Int32|Bool))
        payload["name"]=cmd.name
        payload["description"]=cmd.description
        payload["type"]=1
        if cmd.responds_to?(:options);payload["options"]=cmd.options;end
        payload
      end
      url=if is_global;"/applications/#{app_id}/commands"
      elsif g_id;"/applications/#{app_id}/guilds/#{g_id}/commands"
      else;return;end
      hdrs=HTTP::Headers{"Content-Type"=>"application/json"}
      res=@cli.request(:put_commands,nil,"PUT",url,hdrs,payloads.to_json)
      puts "status: #{res.status_code}"
      if res.status_code!=200&&res.status_code!=201;puts "error: #{res.body}";end
    rescue ex
      puts "load Error: #{ex.message}"
    end end end