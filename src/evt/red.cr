module Evt::Ready
  def self.run(cli,payload)
    puts "visual running as #{payload.user.username}"
    cli.status_update(status:"online",game:Discord::GamePlaying.new(name:"/",type:Discord::GamePlaying::Type::Playing))
  end end