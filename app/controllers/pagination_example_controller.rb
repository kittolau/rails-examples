class EventsController < ApplicationController
  def search
    @events = Event.where( [ "name like ?", "%#{params[:keyword]}%" ]).page(params[:page]).per(5)
    render :action => :index
  end

  def index
    sort_by = (params[:order] == 'name') ? 'name' : 'created_at'
    @events = Event.order(sort_by).page(params[:page]).per(5)
    #@events = Event.all
    #@events = Event.page(params[:page]).per(5)
  end
end

#then you can use this in view
<%= paginate @events %>
