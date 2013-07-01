class ItemsController < ApplicationController
  
  before_filter  :login_required
  
  # GET /items
  # GET /items.json
  def index
    @items = Item.order('created_at DESC').page params[:page]
  end

  # GET /items/1
  # GET /items/1.json
  def show
    @item = Item.find(params[:id])
  end

  # GET /items/new
  # GET /items/new.json
  def new
    @item = Item.new
  end

  # GET /items/1/edit
  def edit
    @item = Item.find(params[:id])
  end

  # POST /items
  # POST /items.json
  def create
    @item = Item.new(params[:item])
    @item.created_by = current_admin.email
    @item.updated_by = current_admin.email
    if @item.save
      redirect_to items_url, notice: 'Item was successfully created.'
    else
      render action: "new"
    end
  end

  # PUT /items/1
  # PUT /items/1.json
  def update
    @item = Item.find(params[:id])
    @item.updated_by = current_admin.email
    if @item.update_attributes(params[:item])
      redirect_to items_url, notice: 'Item was successfully updated.'
    else
      render action: "edit"
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item = Item.find(params[:id])
    @item.disabled = true
    @item.save
    redirect_to items_url
  end
end
