class UsersController < ApplicationController

  # GET: /users
  get "/users" do
    erb :"/users/index.html"
  end

  # GET: /users/new
  get "/users/login" do
    erb :"/users/login.html"
  end

  post '/users/login' do
    user = User.find_by(:username => params[:username])
     if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/users/#{@user.id}"
    else
      @errors = @user.errors.messages
    end
  end

  get '/users/signup' do
    erb :"/users/signup.html"
  end

  # POST: /users
  post "/users/signup" do
    @user = User.new(username: params[:username],password: params[:password], description: params[:description]).valid?
    if @user.save
      redirect "/users/#{@user.id}"
    else
      @errors = @user.errors.messages
    end
  end

  post '/users/signout' do
    session.clear
    redirect '/users'
  end

  # GET: /users/5
  get "/users/:id" do
    erb :"/users/show.html"
  end

  # GET: /users/5/edit
  get "/users/:id/edit" do
    erb :"/users/edit.html"
  end

  # PATCH: /users/5
  patch "/users/:id" do
    redirect "/users/:id"
  end

  # DELETE: /users/5/delete
  delete "/users/:id/delete" do
    redirect "/users"
  end
end
