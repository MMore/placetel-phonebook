require 'sinatra/base'
require 'sinatra/twitter-bootstrap'
require_relative './placetel.rb'

class Phonebook < Sinatra::Base
  register Sinatra::Twitter::Bootstrap::Assets

  # CONFIG
  set :placetel_api_key, "your_api_key"
  set :title, "My Phonebook"
  set :environment, :production
  set :protection, :except => :frame_options # allow embedding in iframes

  api = Placetel.new settings.placetel_api_key

  get '/' do
    @numbers = api.get_numbers
    @numbers.map! {|x|
      {
        fullname: x['name'],
        formatted_number: "#{x['prefix']} #{x['numonly'].insert(-3, '-')}",
        number: x['number']
      }
    }

    erb :index
  end

  get '/initiate_call/:from/:to' do
    api.initiate_call params[:from], params[:to]

    'done'
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
