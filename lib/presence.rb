require 'rubygems'
require 'ruby-asterisk'

$codes = {
            "-1" => "not_found",
            "0"  => "idle",
            "1"  => "in_use",
            "2"  => "busy",
            "4"  => "unavailable",
            "8"  => "ringing",
            "16" => "on_hold"
         }

class Presence
  def initialize(server, port, name, pass)
    @name   = name
    @pass   = pass
    @server = server
    @port   = port
  end

  def state(extn)
    $codes[get_state(extn)]
  end

  private

  def get_state(extn)
    ami  = RubyAsterisk::AMI.new(@server, @port)
    ami.login(@name, @pass)
    result = ami.extension_state(extn, "default")
    result.data[:hints][0]["Status"]
  end
end


