class EventsController < ApplicationController

  before_filter  :login_required

  # GET /events
  # GET /events.json
  def index
    @events = Event.order('created_at DESC').page params[:page]
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @event = Event.find(params[:id])
  end

  # GET /events/new
  # GET /events/new.json
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
    @event = Event.find(params[:id])
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(params[:event])
    event_type = EventType.find(params[:event][:event_type_id])
    @event.description = event_type.description
    @event.booked = event_type.booked
    @event.created_by = current_admin.email
    @event.updated_by = current_admin.email
    if @event.save
      redirect_to @event, notice: 'Event was successfully created.'
    else
      render action: "new"
    end
  end

  # PUT /events/1
  # PUT /events/1.json
  def update
    @event = Event.find(params[:id])
    event_type = EventType.find(params[:event][:event_type_id])
    @event.description = event_type.description
    @event.booked = event_type.booked
    @event.updated_by = current_admin.email
    if @event.update_attributes(params[:event])
      redirect_to @event, notice: 'Event was successfully updated.'
    else
      render action: "edit"
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event = Event.find(params[:id])
    @event.disabled = true
    @event.save
    redirect_to events_url
  end
end
