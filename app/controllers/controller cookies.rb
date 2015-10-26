class ExampleController < ApplicationController
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

end
