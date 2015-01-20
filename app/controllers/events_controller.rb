class EventsController < ApplicationController

  before_action :set_event, :only => [ :show, :edit, :update, :destroy]

  def search
    @events = Event.where( [ "name like ?", "%#{params[:keyword]}%" ]).page(params[:page]).per(5)
    render :action => :index
  end

  def dashboard
      @event = Event.find(params[:id])
  end

  def index
    sort_by = (params[:order] == 'name') ? 'name' : 'created_at'
    @events = Event.order(sort_by).page(params[:page]).per(5)
    #@events = Event.all
    #@events = Event.page(params[:page]).per(5)

      

    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @events.to_xml }
      format.json { render :json => @events.to_json }
      format.atom { @feed_title = "My event list" } # index.atom.builder
    end
  end



  def new
    @event = Event.new
  end

  def edit
    #@event = Event.find(params[:id])
  end

  def update
    #@event = Event.find(params[:id])
    if @event.update(event_params)
      flash[:notice] = "event was successfully updated"
      redirect_to :action => :show, :id => @event
    else
      render :action => :edit
    end
  end

  def destroy
    #@event = Event.find(params[:id])
    @event.destroy

    flash[:alert] = "event was successfully deleted"
    #redirect_to :action => :index
    redirect_to events_url
  end

  def create
    #@event = Event.new(params[:event])
    @event = Event.new(event_params)
    if @event.save
      flash[:notice] = "event was successfully created"
      #redirect_to :action => :index
      redirect_to event_url(@event)
    else
      render :action => :new
    end
  end

  def show
    #@event = Event.find(params[:id])

    #@page_title = @event.name #for the params in the master layout

    respond_to do |format|
      format.html { @page_title = @event.name } # show.html.erb
      format.xml # show.xml.builder
      format.json { render :json => { id: @event.id, name: @event.name }.to_json }
    end
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:name, :description,:category_id, location_attributes: [:name, :_destroy], group_ids: [])
  end
end
