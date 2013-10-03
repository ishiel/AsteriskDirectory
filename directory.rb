require 'rubygems'
require 'sinatra'
require 'active_record'
require 'lib/presence'
require 'haml'
require 'json'
require 'yaml'

$config = YAML.load_file('config.yml')

ActiveRecord::Base.establish_connection($config["mysql"])

$ami = Presence.new($config["ast_server"],$config["ast_port"],$config["ast_user"],$config["ast_pass"])
$exclusions = $config["exclusions"]

class User < ActiveRecord::Base
  def self.find_user(str)
    if $exclusions
      where("extension not in (?) AND (name LIKE ? OR extension LIKE ?)", $exclusions, "%#{str}%", "%#{str}%").select("name, extension").order("extension ASC")    
    else
      where("name LIKE ? OR extension LIKE ?", "%#{str}%", "%#{str}%").select("name, extension").order("extension ASC")    
    end
  end
end

class App < Sinatra::Application
end

get '/' do
  haml :index
end

post '/search' do
  content_type :json
  data   = JSON.parse(request.body.read)
  search = data["term"]
  user   = User.find_user(search)
  user.to_json
end

post '/status' do
  content_type :json
  data   = JSON.parse(request.body.read)
  data['extns'].each {|extn,val|
    state = $ami.state(extn)
    data['extns'][extn] = state
  }
  data.to_json
end

