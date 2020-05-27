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
    if accessible?
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
    col = Collection.new(name: params[:collection][:name], description: params[:collection][:description])
    params["collection"]["items"].each do |item|
      new_item = Item.new(name: item["name"], condition: item["condition"], img_url: item["img_url"])
      new_item.collection = col if new_item.valid?
      col.items << new_item
      new_item.save
    end
    col.user = user
    col.save
    redirect "/users/#{user.id}"
  end

  # GET: /collections/5
  get "/collections/:id" do
    if accessible?
      @collection = Collection.find(params[:id])
      @items = @collection.items
      @user = @collection.user
      erb :"/collections/show.html"
    else
      flash[:message] = 'You must be logged in to use that feature'
      redirect '/users/login'
    end
  end

  # GET: /collections/5/edit
  get "/collections/:id/edit" do
    if accessible?
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
