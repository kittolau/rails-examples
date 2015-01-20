 <%= link_to 'Dashboard', dashboard_event_path(event) %>

<%= event.name %>

<%= link_to event.name, event_path(event) %>
<%= link_to " (XML)", event_path(event, :format => :xml) %>
<%= link_to " (JSON)", event_path(event, :format => :json) %>
<%= link_to 'edit', edit_event_path(event) %>
<%= button_to 'delete', event_path(event), :method => :delete %>

<%= link_to 'Show', :controller => 'events', :action => 'show', :id => event %>
<%= link_to 'Edit', :controller => 'events', :action => 'edit', :id => event %>
<%= link_to 'Delete', :controller => 'events', :action => 'destroy', :id => event %>
<%= button_to 'Delete', event_path(event), :method => :delete %>

<%= link_to 'location', event_location_path(event) %>

<%= form_tag search_events_path, :method => :get do %>
    <%= text_field_tag "keyword" %>
  <%= submit_tag "Search" %>
<% end %>

<%= link_to 'Sort by Name', events_path( :order => "name") %>
<%= link_to 'Sort by Default', events_path %>

<%= link_to 'Destroy', person, method: :delete, data: { confirm: 'Are you sure?' } %>
