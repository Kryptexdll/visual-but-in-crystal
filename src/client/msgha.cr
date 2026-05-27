require"http/headers"
require"json"
class Discord::Client
  def edit_inter(app : String,tok : String,payload : Hash)
    hdrs=HTTP::Headers{"Content-Type"=>"application/json"}
    request(:edit_original_interaction_response,nil,"PATCH","/webhooks/#{app}/#{tok}/messages/@original",hdrs,payload.to_json)
  end
  def req(method,path,body=nil)
    hdrs=HTTP::Headers{"Content-Type"=>"application/json"}
    request(:interaction_response,nil,method,path,hdrs,body.try(&.to_json))
  end end