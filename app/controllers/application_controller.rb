require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "hewwo"
  end

  get '/' do
    erb :index
  end

  helpers do

    def logged_in?
        !!current_user
    end

    def current_user
        @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end

    def login(username, password)
        user = User.find_by(username: username)
        if user && user.authenticate(password)
            session[:user_id] = user.id
        else
            redirect '/login'
        end
    end
end

end
