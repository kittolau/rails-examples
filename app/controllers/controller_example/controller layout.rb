#Layout可以用來包裹Template樣板，讓不同View可以共用Layout作為文件的頭尾。
#因此我們可以為全站的頁面建立共用的版型。這個檔案預設是app/views/layouts/application.html.erb。
#如果在app/views/layouts目錄下有跟某Controller同名的Layout檔案，
#那這個Controller下的所有Views就會使用這個同名的Layout。

class PostsController < ApplicationController
    #如果需要指定Controller的Layout，可以這麼做：
      layout "special"
    #這樣就會指定Events Controller下的Views都使用app/views/layouts/special.html.erb這個Layout，
    #你可以加上參數:only或:except表示只有特定的Action：
      layout "special", :only => :index
      layout "special", :except => [:show, :edit, :new]

    #請注意到使用字串和Symbol是不同的。使用Symbol的話，它會透過一個同名的方法來動態決定，
    #例如以下的Layout是透過determine_layout這個方法來決定：
      layout :determine_layout
      private
      def determine_layout
           ( rand(100)%2 == 0 )? "event_open" : "event_closed"
      end
    #除了在Controller層級設定Layout，我們也可以設定個別的Action使用不同的Layout，例如:
    def show
       @event = Event.find(params[:id])
      render :layout => "foobar"
      #這樣show Action的樣板就會套用foobar Layout。更常見的情形是關掉Layout，
      #這時候我們可以寫render :layout => false。
      render :layout => false
    end

    #自定Layout內容
      #除了<%= yield %>會載入Template內容之外，我們也可以預先自定一些其他的區塊讓Template可以置入內容。
      #例如，要在Layout中放一個側欄用的區塊，取名叫做:sidebar：
      # <div id="sidebar">
      #     <%= yield :sidebar %>
      # </div>
      # <div id="content">
      #     <%= yield %>
      # </div>
      #那麼在Template樣板中，任意地方放:
      # <%= content_for :sidebar do %>
      #    <ul>
      #        <li>foo</li>
      #        <li>bar</li>
      #    </ul>
      # <% end %>
      #除了側欄之外，也常用這招讓每一頁的HTML meta特製化，
      #例如我們可以放Facebook Open Graph，這樣分享到Facebook時，就會抓取你設定的中介資料：

      # <head>
      #   <title>YourApplicationName</title>
      #   <%= stylesheet_link_tag    'application', media: 'all', 'data-turbolinks-track' => true %>
      #   <%= javascript_include_tag 'application', 'data-turbolinks-track' => true %>
      #   <%= csrf_meta_tags %>
      #   <%= yield :head %>
      # </head>
      # 在Template樣板中，加入：

      # <%= content_for :head do %>
      #     <%= tag(:meta, :content => @event.name, :property => "og:title") %>
      #     <%= tag(:meta, :content => @event.description, :property => "og:description") %>
      #     <%= tag(:meta, :content => "article", :property => "og:type") %>
      #     <%= tag(:meta, :content => @event.logo.url, :property => "og:image") %>
      #     <%= tag(:meta, :content => event_url(@event), :property => "og:url") %>
      # <% end %>
end
