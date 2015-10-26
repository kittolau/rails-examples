class ExampleController < ApplicationController
  #session
    #Rails預設採用Cookies session storage來儲存Session資料，
    #它是將Session資料透過config/secrets.yml的secret_key_base編碼後放到瀏覽器的Cookie之中，
    #最大的好處是對伺服器的效能負擔很低，缺點是大小最多4Kb，
    #以及資料還是可以透過反編碼後看出來，只是無法進行修改。
    #因此安全性較低，不適合存放機密資料。

    #除了Cookies session storage，Rails也支援其他方式，你可以修改config/initializers/session_store.rb：
    # =>  :active_record_store 使用資料庫來儲存
    # =>  :mem_cache_store 使用Memcached快取系統來儲存，適合高流量的網站
    # 一般來說使用預設的Cookies session storage即可，
    # 如果對安全性較高要求，可以使用資料庫。
    # 如果希望兼顧效能，可以考慮使用Memcached。
    #
    # 採用:active_record_store的話，
    # 必須安裝activerecord-session_store gem，
    # 然後產生sessions資料表：

    session[:user] = @user
    flash[:message] = "Data was saved successfully"
    # <%= link_to "login", :action => 'login' unless session[:user] %>
    # <% if flash[:message] %>
    #   <div>
    #     <%= h flash[:message] %>
    #   </div>
    # <% end %>

    #It's possible to turn off session management:
    session :off                        # turn session management off
    session :off, :only => :action      # only for this :action
    session :off, :except => :action    # except for this action
    session :only => :foo,              # only for :foo when doing HTTPS
            :session_secure => true
    session :off, :only=>:foo, # off for foo,if uses as Web Service
            :if => Proc.new { |req| req.parameters[:ws] }
end
