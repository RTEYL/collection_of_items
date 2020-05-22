class CollectionsController < ApplicationController

  # GET: /collections
  get "/collections" do
    if logged_in?
      erb :"/collections/index.html"
    else
      flash[:message] = 'You must be logged in to use that feature'
      redirect '/users/login'
    end
  end

  # GET: /collections/new
  get "/collections/new" do
    if logged_in? && current_user
      erb :"/collections/new.html"
    else
      flash[:message] = 'You must be logged in to use that feature'
      redirect '/users/login'
    end
  end

  # POST: /collections
  post "/collections" do
    user = User.find(session["user_id"])
    params.delete_if{|p| p == "submit"}
    params[:user_id] = user.id
    Collection.create(params)
    redirect "/users/#{user.id}"
  end

  # GET: /collections/5
  get "/collections/:id" do
    if logged_in? && current_user
      erb :"/collections/show.html"
    else
      flash[:message] = 'You must be logged in to use that feature'
      redirect '/users/login'
    end
  end

  # GET: /collections/5/edit
  get "/collections/:id/edit" do
    if logged_in? && current_user
      erb :"/collections/edit.html"
    else
      flash[:message] = 'You must be logged in to use that feature'
      redirect '/users/login'
    end
  end

  # PATCH: /collections/5
  patch "/collections/:id" do
    redirect "/collections/:id"
  end

  # DELETE: /collections/5/delete
  delete "/collections/:id/delete" do
    redirect "/collections"
  end
end
