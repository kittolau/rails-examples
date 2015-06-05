Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # _path and _url
  #resources:
    #index
    events_path
    #show
    event_path(e)
    #update
    edit_event_path
    #new
    new_events_path
    #collection
    action_name_events_path
    #member
    action_name_event_path(e)

  #root
    root :to => "welcome#index"

  #resources
    #filter out not needed route
    resource :events, :except => [:index, :show]
    resource :events, :only => :create
    resources :state, :controller => 'event_states'
    resources :events do
      #sub resources
        #resources
          #resources and resource does not matter with the name of controller is plural or singular
          resources :attendees, :controller => 'event_attendees'
        #resource
          #singular resource does not has index action, so no some method like event_locations_path and event_location_path(event, location)
          resource :location, :controller => 'event_locations'

      #adding addition route
        #Collection
          #GET    /events/search # eventsController#search

          # A collection route doesn't because it acts on a collection of objects.
          # Search is an example of a collection route, because it acts on (and displays) a collection of objects.
          collection do
              get :search
          end
        #member
          #GET    /events/:id/dashboard # eventsController#dashboard

          # A member route will require an ID, because it acts on a member.
          # Preview is an example of a member route, because it acts on (and displays) a single object.
          member do
              get :dashboard
          end

        #match
          #collection
          #GET /events/<any_word>
          get '/:provider' => 'device_authentications#create', :on => :collection

          #member
          #GET /events/:event_id/<any_word>
          get '/:provider' => 'device_authentications#create'
    end

  #Name space
    #Namespace是Scope的一種特定應用，特別適合例如後台介面，這樣就整組controller、網址path、URL Helper前置名稱`都影響到：
    #如此controller會是Admin::ProjectsController，網址如/admin/projects，而URL Helper如admin_projects_path這樣的形式。
    #get /admin/events
    namespace :admin, defaults: {format: 'json'} do
      resources :projects
    end
    # the default format is used with respond_with function such that the default format will be used

  #scope
    #Module參數則可以讓Controller分Module，例如
    #如此controller會是ApiV1::ProjectsController，網址如/api/v1/projects，而URL Helper如v1_projects_path這樣的形式。
    scope :path => '/api/v1/', :module => "api_v1", :as => 'v1' do
      resources :projects
    end

    get 'foo/meetings/:id', :to => 'events#show'
    post 'foo/meetings', :to => 'events#create'
    #可以改寫成
    scope :controller => "events", :path => "/foo", :as => "bar" do
      get "meetings/:id" => :show, :as => "meeting"
      post "meetings" => :create , :as => "meetings"
    end
    #其中as會產生URL helper是bar_meeting_url和bar_meetings_url。

  #constraint
    #我們可以利用:constraints設定一些參數限制，例如限制:id必須是整數。
    #match "/events/show/:id" => "events#show", :constraints => {:id => /\d/}
    #另外也可以限定subdomain子網域：
    namespace :admin do
      constraints subdomain: 'admin' do
           resources :photos
      end
    end
    #甚至可以限定IP位置：
    constraints(:ip => /(^127.0.0.1$)|(^192.168.[0-9]{1,3}.[0-9]{1,3}$)/) do
        #match "/events/show/:id" => "events#show"
    end

    scope constraints: ->(request){ request.env['warden'].user.nil? } do
      resources :photos
    end

    #limit the resources to be in module v1,
    #also the ApiConstraints is placed in lib directory, such that the option is passd in
    require 'api_contstraints'
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
      resources :products
    end

    class ApiConstraints
      def initialize(options)
        @verison = options[:version]
        @default = options[:default]
      end

      def matches?(request)
        @default || request.headers['Accpet'].include?("application/vnd.example.v#{@version}")
      end
    end

  #match
    #may have security problem since all public action can be accessed, also we want only POST for create
    match ':controller(/:action(/:id(.:format)))', :via => :all

    match "account/overview" => "account#overview", :via => :get
    match "account/setup" => "account#setup", :via => [:get, :post]
    match "account/overview" => "account#overview", :via => :any
    #OR
    get "account/overview" => "account#overview"
    get "account/setup" => "account#setup"
    post "account/setup" => "account#setup"

    # "as" will generate welcome_path and welcome_url helper method
    get "welcome/say_hello" => "welcome#say", :as => "welcome"
    get "welcome" => "welcome#index"

  #redirect to static page
    get "/foo" => redirect("/bar")
    get "/ihower" => redirect("http://ihower.tw")

end
