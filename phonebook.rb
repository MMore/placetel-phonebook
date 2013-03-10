require 'sinatra/base'
require 'sinatra/twitter-bootstrap'
require_relative './placetel.rb'

class Phonebook < Sinatra::Base
  register Sinatra::Twitter::Bootstrap::Assets

  # CONFIG
  set :placetel_api_key, "your_api_key"
  set :title, "My Phonebook"

  api = Placetel.new settings.placetel_api_key

  get '/' do
    @numbers = api.get_numbers

    erb :index
  end

  not_found do
    @error = "Site #{env['REQUEST_PATH']} not found"
    erb :error
  end

  error do
    @error = env['sinatra.error'].message
    [500, erb(:error)]
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
