class UomsController < ApplicationController

  before_filter  :login_required
  
  # GET /uoms
  # GET /uoms.json
  def index
    @uoms = Uom.order('created_at DESC').page params[:page]
  end

  # GET /uoms/1
  # GET /uoms/1.json
  def show
    @uom = Uom.find(params[:id])
  end

  # GET /uoms/new
  # GET /uoms/new.json
  def new
    @uom = Uom.new
  end

  # GET /uoms/1/edit
  def edit
    @uom = Uom.find(params[:id])
  end

  # POST /uoms
  # POST /uoms.json
  def create
    @uom = Uom.new(params[:uom])
    @uom.created_by = current_admin.email
    @uom.updated_by = current_admin.email
    if @uom.save
      redirect_to uoms_url, notice: 'Uom was successfully created.'
    else
      render action: "new"
    end
  end

  # PUT /uoms/1
  # PUT /uoms/1.json
  def update
    @uom = Uom.find(params[:id])
    @uom.updated_by = current_admin.email
    if @uom.update_attributes(params[:uom])
      redirect_to uoms_url, notice: 'Uom was successfully updated.'
    else
      render action: "edit"
    end
  end

  # DELETE /uoms/1
  # DELETE /uoms/1.json
  def destroy
    @uom = Uom.find(params[:id])
    @uom.disabled = true
    @uom.save
    format.html { redirect_to uoms_url }
  end
end
