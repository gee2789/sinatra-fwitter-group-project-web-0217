class UserController < ApplicationController

  get '/' do
    erb :'/users/homepage'
  end

  get '/signup' do
    if session[:id] == nil
      erb :'users/index'
    else
      redirect '/tweets'
    end
  end


  post '/signup' do
    if params["username"]=="" || params["email"]=="" || params["password"]==""
      redirect '/signup'
    else
      @user = User.create(params)
      session[:id] = @user.id
      redirect '/tweets'
    end
  end

  get '/login' do
    if session[:id] == nil
      erb :'/users/login'
    else
      redirect '/tweets'
    end
  end

  post '/login' do
    # binding.pry
    if @user = User.all.find_by(username: params["username"], password: params["password"])
      session[:id] = @user.id
      redirect '/tweets'
    else
      redirect '/login'
    end
  end

  get '/logout' do
    if session[:id] != nil
      session.clear
      redirect '/login'
    else
      redirect '/'
    end
  end

  get '/users/:slug' do
    @users = User.find_by_slug(params["slug"])
    erb :'users/show'
  end


end
