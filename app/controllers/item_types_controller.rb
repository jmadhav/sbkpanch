class ItemTypesController < ApplicationController
  
  before_filter  :login_required
  
  # GET /item_types
  # GET /item_types.json
  def index
    @item_types = ItemType.order('created_at DESC').page params[:page]
  end

  # GET /item_types/1
  # GET /item_types/1.json
  def show
    @item_type = ItemType.find(params[:id])
  end

  # GET /item_types/new
  # GET /item_types/new.json
  def new
    @item_type = ItemType.new
  end

  # GET /item_types/1/edit
  def edit
    @item_type = ItemType.find(params[:id])
  end

  # POST /item_types
  # POST /item_types.json
  def create
    @item_type = ItemType.new(params[:item_type])
    @item_type.created_by = current_admin.email
    @item_type.updated_by = current_admin.email
    if @item_type.save
      redirect_to item_types_url, notice: 'Item type was successfully created.'
    else
      render action: "new"
    end
  end

  # PUT /item_types/1
  # PUT /item_types/1.json
  def update
    @item_type = ItemType.find(params[:id])
    @item_type.updated_by = current_admin.email
    if @item_type.update_attributes(params[:item_type])
      redirect_to item_types_url, notice: 'Item type was successfully updated.'
    else
      render action: "edit"
    end
  end

  # DELETE /item_types/1
  # DELETE /item_types/1.json
  def destroy
    @item_type = ItemType.find(params[:id])
    @item_type.disabled = true
    @item_type.save
    redirect_to item_types_url
  end
end
