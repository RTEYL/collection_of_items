class CollectionsController < ApplicationController

  # GET: /collections
  get "/collections" do
    if logged_in?
      @users = User.all
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
      if item["name"] != ""
        new_item = Item.new(name: item["name"], condition: item["condition"], img_url: item["img_url"])
        if new_item.valid?
          new_item.collection = col
          new_item.save
          col.items << new_item
        else
          flash[:message] = "Invalid Image Url"
          redirect "/collections/new"
        end
      end
    end
    if col.valid?
      col.user = user
      col.save
    else
      flash[:message] = col.errors.messages
      redirect "/collections/new"
    end
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
      @collection = Collection.find_by_id(params[:id])
      erb :"/collections/edit.html"
    else
      flash[:message] = 'You must be logged in to use that feature'
      redirect '/users/login'
    end
  end

  # PATCH: /collections/5
  patch "/collections/:id" do
    col = Collection.find(params[:id])
    col.update(name: params[:collection][:name], description: params[:collection][:description], item_ids: params[:collection][:item_ids])
    if params[:collection][:items]["name"] != ""
      item = Item.new(
        name: params[:collection][:items]["name"],
        condition: params[:collection][:items]["condition"],
        img_url: params[:collection][:items]["img_url"]
      )
      if item.valid?
        item.collection = col
        item.save
        col.items << item
      else
        flash[:message] = item.error.messages
        redirect "/collections/#{col.id}"
      end
    end
    col.save if col.valid?
    redirect "/collections/#{col.id}}"
  end

  # DELETE: /collections/5/delete
  delete "/collections/:id/delete" do
    redirect "/collections"
  end
end
