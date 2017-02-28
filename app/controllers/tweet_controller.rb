class TweetController < ApplicationController

  get '/tweets' do
    if session[:id]==nil
      redirect 'users/login'
    else
      @user = User.find(session[:id])
      erb :'tweets/index'
    end
  end

  get '/tweets/new' do
    if session[:id]==nil
      redirect 'users/login'
    else
      erb :'tweets/new'
    end
  end

  post '/tweets' do
    if params["content"]==""
      redirect '/tweets/new'
    else
      @user = User.find(session[:id])
      @user.tweets << Tweet.create(params)
    end
    redirect '/tweets'
  end

end
