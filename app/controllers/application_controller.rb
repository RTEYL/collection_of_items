require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, 'asdfasdfghjghj6'
  end

  get "/" do
    erb :"/users/index.html"
  end

end
