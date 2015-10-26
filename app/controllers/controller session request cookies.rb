class ExampleController < ApplicationController
  #turn off CSRF token checking for web api
  skip_before_action :verify_authenticity_token

  #Variable in Controller
  #action_name
    #get the current action name
    action_name
  #cookies
    cookies[:user_name] = "david" # Set a simple session cookie
    cookies[:login] = { :value => "XJ12", :expires => Time.now + 3600}     # Set a cookie that expires in 1 hour
    cookies[:key] = {
       :value => 'a yummy cookie',
       :expires => 1.year.from_now,
       :domain => 'domain.com'
    }
      # value - the cookie.s value or list of values (as an array).
      # path - the path for which this cookie applies. Defaults to the root of the application.
      # domain - the domain for which this cookie applies.
      # expires - the time at which this cookie expires, as a +Time+ object.
      # secure - whether this cookie is a secure cookie or not (default to false). Secure cookies are only transmitted to HTTPS servers.
    cookies[:user_name]  # => "david"
    cookies.size         # => 2
    cookies.delete :user_name
    cookies.delete(:key, :domain => 'domain.com')
    #因為資料是存放在使用者瀏覽器，所以如果需要保護不能讓使用者亂改，Rails也提供了Signed方法：
    cookies.signed[:user_preference] = @current_user.preferences
    #另外，如果是盡可能永遠留在使用者瀏覽器的資料，可以使用Permanent方法：
    cookies.permanent[:remember_me] = [current_user.id, current_user.salt]
    #兩者也可以加在一起用：
    cookies.permanent.signed[:remember_me] = [current_user.id, current_user.salt]
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

  #headers


  #params
    #正確的說，params這個Hash是ActiveSupport::HashWithIndifferentAccess物件，而不是普通的Hash而已。
    #Ruby內建的Hash，用Symbol的hash[:foo]和用字串的hash["foo"]是不一樣的，這在混用的時候常常搞錯而取不到值，算是常見的臭蟲來源。
    #Rails在這裡使用的ActiveSupport::HashWithIndifferentAccess物件，無論鍵是Symbol或字串，都指涉相同的值，減少麻煩。

    params[:query_string_key]
    #fetch
      #Returns a parameter for the given key. If the key can't be found, there are several options:
      # => With no other arguments, it will raise an ActionController::ParameterMissing error;
      # => if more arguments are given, then that will be returned;
      # => if a block is given, then that will be run and its result returned.
      params = ActionController::Parameters.new(person: { name: 'Francesco' })
      params.fetch(:person)               # => {"name"=>"Francesco"}
      params.fetch(:none)                 # => ActionController::ParameterMissing: param not found: none
      params.fetch(:none, 'Francesco')    # => "Francesco"
      params.fetch(:none) { 'Francesco' } # => "Francesco"
    #slice
      #Returns a new ActionController::Parameters instance that includes only the given keys. If the given keys don't exist, returns an empty hash.
      params = ActionController::Parameters.new(a: 1, b: 2, c: 3)
      params.slice(:a, :b) # => {"a"=>1, "b"=>2}
      params.slice(:d)     # => {}

  #request
    #request 各種關於此request的詳細資訊
      request_method
      method
      delete?, get?, head?, post?, put?
      xml_http_request? 或 xhr?
      url
      protocol, host, port, path 和 query_string
      domain
      host_with_port
      port_string
      ssl?
      remote_ip?
      path_without_extension, path_without_format_and_extension, format_and_extension, relative_path
      env
      accepts
      format
      mime_type
      content_type
      headers
      body
      content_length

  #response
    #代表要回傳的內容，會由Rails設定好。通常你會用到的時機是你想加特別的Response Header。
    #add custom HTTP header
    response.headers['HEADER NAME'] = 'HEADER VALUE'

end
