require "./ping"
require"./uptime"
require"./say"
module Cmds
  def self.all
    [Ping,Uptime,Say,Raid]
  end
end