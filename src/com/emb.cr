require"json"
require"time"
module Com
  class Embed
    def initialize
      @data={} of String=>JSON::Any end
    def title(val : String)
      @data["title"]=JSON::Any.new(val)
      self end
    def description(val : String)
      @data["description"]=JSON::Any.new(val)
      self end
    def color(val : Int32)
      @data["color"]=JSON::Any.new(val.to_i64)
      self end
    def url(val : String)
      @data["url"]=JSON::Any.new(val)
      self end
    def image(url : String)
      @data["image"]=JSON::Any.new({"url"=>JSON::Any.new(url)})
      self end
    def thumbnail(url : String)
      @data["thumbnail"]=JSON::Any.new({"url"=>JSON::Any.new(url)})
      self end
    def footer(text : String,icon_url : String?=nil)
      ft={"text"=>JSON::Any.new(text)}
      ft["icon_url"]=JSON::Any.new(icon_url) if icon_url
      @data["footer"]=JSON::Any.new(ft)
      self end
    def author(name : String, icon_url : String?=nil,url : String?=nil)
      au={"name" => JSON::Any.new(name)}
      au["icon_url"]=JSON::Any.new(icon_url) if icon_url
      au["url"]=JSON::Any.new(url) if url
      @data["author"]=JSON::Any.new(au)
      self end
    def timestamp(time : Time=Time.utc)
      @data["timestamp"]=JSON::Any.new(time.to_rfc3339)
      self end
    def build
      @data
    end end end