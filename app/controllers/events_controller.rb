class EventsController < ApplicationController

  before_action :set_event, :only => [ :show, :edit, :update, :destroy]

  before_action :authenticate_user!

  def index
    # GET /events/index
    # GET /events
    @events = Event.page(params[:page]).per(5)

    Rails.logger.debug("event: #{@event.inspect}")

    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @events.to_xml }
      format.json { render :json => @events.to_json }
      format.atom { @feed_title = "My event list" } # index.atom.builder
    end
  end

  # GET /event/new
  def new
    @event = Event.new
  end

  # POST /event/create
  def create
    @event = Event.new(event_params)
    @event.user = current.user
    if @event.save
      flash[:notice] = "event was successfully created"
      redirect_to events_url
    else
      #redirect_to :action => :new 不這樣做是因為想記得之前使用者在網頁中輸入的資料
      render :action => :new
    end

  end

  # GET /event/show
  def show
    @page_title = @event.name
    respond_to do |format|
      format.html { @page_title = @event.name } # show.html.erb
      format.xml # show.xml.builder
      format.json { render :json => { id: @event.id, name: @event.name }.to_json }
    end
  end

  def edit
  end

  def update
    # @event.update_attributes(event_params)
    flash[:notice] = "event was successfully updated"
    @event.attributes = event_params
    @event.save

    redirect_to event_url(@event)
  end

  def destroy
    @event.destroy
    flash[:alert] = "event was successfully deleted"

    redirect_to events_url
  end

  def search
    @events = Event.where( [ "name like ?", "%#{params[:keyword]}%" ]).paginate( :page => params[:page] )
    render :action => :index
  end

  private

  def event_params
    params.require(:event).permit(:name, :description, :category_id)
  end

  def set_event
    @event = Event.find(params[:id])
  end

end
