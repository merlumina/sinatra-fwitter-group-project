class UsersController < ApplicationController

    get '/signup' do
        if !logged_in?
            erb :'users/new'
        else
            redirect to '/tweets'
        end
    end

    post '/signup' do
        if params[:username] == "" || params[:email] == "" || params[:password] == ""
            redirect to '/signup'
        else
            @user = User.new(username: params[:username], email: params[:email], password: params[:password])
            @user.save
            session[:user_id] = @user.id
            redirect '/tweets'
        end
    end

    get '/login' do
        if !logged_in?
            erb :"users/login"
        else
            redirect to '/tweets'
        end
    end

    post '/login' do
        login(params[:username], params[:password])
        redirect '/tweets'
    end

    get '/logout' do
        if logged_in?
            session.destroy
            redirect '/login'
        else
            redirect '/'
        end
    end

end
