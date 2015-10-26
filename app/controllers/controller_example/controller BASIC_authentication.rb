#Rails內建支援HTTP Basic Authenticate，可以很簡單實作出認證功能：
class PostsController < ApplicationController
    before_action :authenticate

    protected

    def authenticate
     authenticate_or_request_with_http_basic do |username, password|
       username == "foo" && password == "bar"
     end
    end
end

#或是這樣寫：
class PostsController < ApplicationController
    http_basic_authenticate_with :name => "foo", :password => "bar"
end
