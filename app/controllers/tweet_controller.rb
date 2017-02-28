class TweetController < ApplicationController

  get '/tweets' do
    if session[:id]==nil
      redirect '/login'
    else
      @user = User.find(session[:id])
      erb :'tweets/index'
    end
  end

  get '/tweets/new' do
    if session[:id]==nil
      redirect '/login'
    else
      erb :'tweets/new'
    end
  end

  post '/tweets' do
    if session[:id]==nil
      redirect '/login'
    else
      if params["content"]==""
        redirect '/tweets/new'
      else
        @user = User.find(session[:id])
        @user.tweets << Tweet.create(params)
      end
    end
  end

  get '/tweets/:id' do
    if session[:id]==nil
      redirect '/login'
    else
      @tweet = Tweet.find(params[:id])
      erb :'tweets/show'
    end
  end


  post '/tweets/:id' do
    if params["content"]==""
      redirect '/tweets/new'
    else
      @user = User.find(session[:id])
      @user.tweets << Tweet.create(params)
    end
    redirect '/tweets'
  end

  get '/tweets/:id/edit' do
    if session[:id]==nil
      redirect '/login'
    end
    @tweet = Tweet.find(params[:id])
    if @tweet.user_id == session[:id]
      erb :'/tweets/edit'
    else
      redirect '/tweets'
    end
  end

  patch '/tweets/:id/edit' do
    @tweet = Tweet.find(params[:id])
    @tweet.update(content: params[:content])
    @tweet.save
    redirect "/tweets/#{@tweet.id}/edit"
  end

  delete '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    if session[:id]==@tweet.user_id
      @tweet.destroy
      redirect '/tweets'
    else
      redirect "/tweets/#{@tweet.id}"
    end
  end


end
