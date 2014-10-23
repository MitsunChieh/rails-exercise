class EventsController < ApplicationController
  def index
    # GET /events/index
    # GET /events
    @events = Event.all
  end

  # GET /event/new
  def new
    @event = Event.new
  end

  # POST /event/create
  def create
    @event = Event.new(event_params)
    @event.save

    redirect_to :action => :index
  end

  # GET /event/show
  def show
    @event = Event.find(params[:id])
  end

  private

  def event_params
    params.require(:event).permit(:name, :description)
  end
end
