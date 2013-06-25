class UomsController < ApplicationController

  before_filter  :login_required
  
  # GET /uoms
  # GET /uoms.json
  def index
    @uoms = Uom.order('created_at DESC').page params[:page]

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @uoms }
    end
  end

  # GET /uoms/1
  # GET /uoms/1.json
  def show
    @uom = Uom.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @uom }
    end
  end

  # GET /uoms/new
  # GET /uoms/new.json
  def new
    @uom = Uom.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @uom }
    end
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
    respond_to do |format|
      if @uom.save
        format.html { redirect_to uoms_url, notice: 'Uom was successfully created.' }
        format.json { render json: @uom, status: :created, location: @uom }
      else
        format.html { render action: "new" }
        format.json { render json: @uom.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /uoms/1
  # PUT /uoms/1.json
  def update
    @uom = Uom.find(params[:id])
    @uom.updated_by = current_admin.email
    respond_to do |format|
      if @uom.update_attributes(params[:uom])
        format.html { redirect_to uoms_url, notice: 'Uom was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @uom.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /uoms/1
  # DELETE /uoms/1.json
  def destroy
    @uom = Uom.find(params[:id])
    @uom.disabled = true
    @uom.save

    respond_to do |format|
      format.html { redirect_to uoms_url }
      format.json { head :no_content }
    end
  end
end
