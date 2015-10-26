
#nested attributes via has many through
  class Notice < ActiveRecord::Base
    # attribute :title
    has_many :entity_roles
    has_many :entities, through: :entity_roles
    accepts_nested_attributes_for :entity_roles
  end

  class EntityRole < ActiveRecord::Base
    # attribute :name
    belongs_to :entity
    belongs_to :notice
    validates_presence_of :entity
    validates_presence_of :notice
    accepts_nested_attributes_for :entity
  end

  class Entity < ActiveRecord::Base
    # attribute :name
    # attribute :address
    has_many :entity_roles
    has_many :notices, through: :entity_roles
  end

  class NoticesController < ApplicationController

    def new
      @notice = Notice.new
      @notice.entity_roles.build(name: 'submitter').build_entity
      @notice.entity_roles.build(name: 'recipient').build_entity
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

    def event_params
      params.require(:notice).permit(:title, entity_roles_attributes: [:name, entity_attributes:[:name,:address]], group_ids: [])
    end
  end



  <%= simple_form_for(@notice) do |form| %>
    <%= form.input :title %>

    <%= form.simple_fields_for(:entity_roles) do |roles_form| %>
      <% role = roles_form.object.name.titleize %>
      <%= roles_form.input :name, as: :hidden %>
      <%= roles_form.simple_fields_for(:entity) do |entity_form| %>
        <%= entity_form.input :name, label: "#{role} Name" %>
        <%= entity_form.input :address, label: "#{role} Address" %>
      <% end %>
    <% end %>

    <%= form.submit "Submit" %>
  <% end %>

  #when the form submit
  #Rails was not setting the notice attribute on the EntityRole before attempting to save it, triggering the validation errors.

  class Notice < ActiveRecordBase
    has_many :entity_roles, inverse_of: :notice
  end

  #by addin inverso_of, the problem is sovled
