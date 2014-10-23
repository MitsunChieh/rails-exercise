class EventsController < ApplicationController

  before_action :set_event, :only => [ :show, :edit, :update, :destroy]

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

    if @event.save
      flash[:notice] = "event was successfully created"
      redirect_to :action => :index
    else
      #redirect_to :action => :new 不這樣做是因為想記得之前使用者在網頁中輸入的資料
      render :action => :new
    end

  end

  # GET /event/show
  def show
    @page_title = @event.name
  end

  def edit
  end

  def update
    # @event.update_attributes(event_params)
    flash[:notice] = "event was successfully updated"
    @event.attributes = event_params
    @event.save

    redirect_to :action => :show, :id => @event
  end

  def destroy
    @event.destroy
    flash[:alert] = "event was successfully deleted"

    redirect_to :action => :index
  end

  private

  def event_params
    params.require(:event).permit(:name, :description)
  end

  def set_event
    @event = Event.find(params[:id])
  end

end
