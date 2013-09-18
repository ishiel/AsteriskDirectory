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

class User < ActiveRecord::Base
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
  user   = User.where("name LIKE ? OR extension LIKE ?", "%#{search}%","%#{search}%").select("name, extension").order("extension ASC")
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

