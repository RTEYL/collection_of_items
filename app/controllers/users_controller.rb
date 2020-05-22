class UsersController < ApplicationController

  # GET: /users
  get "/users" do
    @session = session
    if @session["user_id"]
      redirect "/users/#{@session["user_id"]}"
    else
      redirect '/users/login'
    end
  end

  # GET: /users/new
  get "/users/login" do
    if logged_in?
      flash[:message] = "User already logged in."
      redirect '/users'
    else
      erb :"/users/login.html"
    end
  end

  post '/users/login' do
    user = User.find_by(:username => params[:username])
     if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/users/#{user.id}"
    else
    flash[:message] = 'Invalid login credentials'
    redirect '/users/login'
    end
  end

  get '/users/signup' do
    if logged_in?
      flash[:message] = "User already logged in."
      redirect '/users'
    else
      erb :"/users/signup.html"
    end
  end

  # POST: /users
  post "/users/signup" do
    user = User.new(username: params[:username], password: params[:password], password_confirmation: params[:password_confirmation], description: params[:description])
    if user.valid?
      user.save
      redirect "/users/login"
    else
      flash[:message] = user.errors.messages
    end
  end

  # GET: /users/5
  get "/users/:id" do
    @user = User.find_by_id(params[:id])
    if @user && @user == current_user
      erb :"/users/show.html"
    else
      redirect '/users'
    end
  end

  # GET: /users/5/edit
  get "/users/:id/edit" do
    @user = User.find_by_id(params[:id])
    if @user == current_user
      erb :"/users/edit.html"
    else
      redirect '/users'
    end
  end

  # PATCH: /users/5
  patch "/users/:id" do
    user = User.find_by_id(params[:id])
    user.update(username: params[:username], password: params[:password], password_confirmation: params[:password_confirmation], description: params[:description])
    if params[:password]
      user.authenticate(params[:password])
      flash.now[:message] = "Invald password" if !user.valid?
      user.save
    else
      redirect to "/users/#{params[:id]}"
    end
  end

  # DELETE: /users/5/delete
  delete "/users/:id/delete" do
    User.delete(params[:id])
      redirect "/users/login"
    end

  post '/users/logout' do
    session.clear
    redirect '/users'
  end
end
