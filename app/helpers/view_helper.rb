module ActiveRecordExampleHelper
  #module namespace
    #in helpers/admin/events_helper.rb
    module Admin::EventsHelper
    end

  #helper Module
    #要建立自定的Helper，只需要將方法定義在app/helpers/目錄下的任意檔案就可以了。

    #產生Controller的同時，Rails就會自動產生一個同名的Helper檔案，照慣例該Controller下的Template所用的Helper，就放在該檔案下。

    #如果是全站使用的Helper，則會放在app/helpers/application_helper_rb

    #Helper是全域的，定義在哪一個檔案中沒有關係，檔案名稱也不需要與Controller名稱對應。
    #By default, each controller will include all helpers.
    #In previous versions of Rails the controller will include a helper whose name matches that of the controller,
    #e.g., MyController will automatically include MyHelper.
    #To return old behavior set
    #config.action_controller.include_all_helpers to false.

    module ApplicationHelper
      def gravatar_url(email)
       gravatar_email = Digest::MD5.hexdigest(email.downcase)
       return "http://www.gravatar.com/avatar/#{gravatar_email}?s=48"
      end
    end
    #如此便可以在Template中這樣使用：
    #<%= image_tag gravatar_url(user.email) %>

  #controller helper
    #另外，Controller裡面定義的方法，也可以用helper_method曝露出來當作Helper，例如
    class ApplicationController < ActionController::Base
      #...
      helper_method :current_user

      protected

      def current_user
        @current_user = User.find(session[:user_id]) if session[:user_id]
      end
    end

  #using helper in controller
    include MyHelpers::MenuHelper

    Menu.new
    method()
    #OR
    MyHelpers::MenuHelper::Menu.new
    MyHelpers::MenuHelper.method()
end
