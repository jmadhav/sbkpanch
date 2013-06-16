class EventTypesController < ApplicationController
  
  before_filter  :login_required

  # GET /event_types
  # GET /event_types.json
  def index
    @event_types = EventType.order('created_at DESC').page params[:page]

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @event_types }
    end
  end

  # GET /event_types/1
  # GET /event_types/1.json
  def show
    @event_type = EventType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @event_type }
    end
  end

  # GET /event_types/new
  # GET /event_types/new.json
  def new
    @event_type = EventType.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @event_type }
    end
  end

  # GET /event_types/1/edit
  def edit
    @event_type = EventType.find(params[:id])
  end

  # POST /event_types
  # POST /event_types.json
  def create
    logger.info params[:event_type].inspect
    @event_type = EventType.new(params[:event_type])
    @event_type.booked = get_booked(params[:event_type][:event_type_item_details_attributes])
    @event_type.created_by = current_admin.email
    @event_type.updated_by = current_admin.email
    respond_to do |format|
      if @event_type.save
        format.html { redirect_to @event_type, notice: 'Event type was successfully created.' }
        format.json { render json: @event_type, status: :created, location: @event_type }
      else
        format.html { render action: "new" }
        format.json { render json: @event_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /event_types/1
  # PUT /event_types/1.json
  def update
    @event_type = EventType.find(params[:id])
    @event_type.booked = get_booked(params[:event_type][:event_type_item_details_attributes])
    @event_type.updated_by = current_admin.email
    respond_to do |format|
      if @event_type.update_attributes(params[:event_type])
        format.html { redirect_to @event_type, notice: 'Event type was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @event_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /event_types/1
  # DELETE /event_types/1.json
  def destroy
    @event_type = EventType.find(params[:id])
    @event_type.disabled = true
    @event_type.save

    respond_to do |format|
      format.html { redirect_to event_types_url }
      format.json { head :no_content }
    end
  end
  
  protected
    def get_booked items
      unless items.blank?
        items = items.collect{ |k,v| unless (v["_destroy"].to_i == 1); Item.find(v['item_id']).name; end  }
        items.delete(nil)
      else
        items = []
      end
      count, booked = 1, ""
      items.each do |i|
        if count == 1
          booked = booked + i 
        elsif count == items.size && items.size > 1
          booked = booked + " and " + i
        else
          booked = booked + ", " + i 
        end
        count += 1
      end
      booked
    end
end
