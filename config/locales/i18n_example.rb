# Files in the config/locales directory are used for internationalization
# and are automatically loaded by Rails. If you want to use locales other
# than English, add the necessary files in this directory.
#
# To learn more, please read the Rails Internationalization guide
# available at http://guides.rubyonrails.org/i18n.html.

#Usage
  # To use the locales, use `I18n.t`:

    I18n.t 'hello'

    #example
    "zh-TW"
      admin:
        event: 活動
    I18n.t("admin.event")
    I18n.t(:event, :scope => :admin )

    #要在詞彙內嵌的話，可以使用%{variable_name}：
    "zh-TW"
        hello: "親愛的%{name}你好!"
    I18n.t(:hello, :name => @user.name) # 親愛的XXX你好

  # In views, this is aliased to just `t`:
   #<%= t('hello') %>

  # To use a different locale, set it with `I18n.locale`:
    I18n.locale = :es
    # This would use the information in config/locales/es.yml.

#搭配Model使用
  # 在套用上述的翻譯詞彙檔之後，你可能會注意到Model驗證錯誤訊息會變成如Name 不能是空白字元，如果需要近一步中文化欄位名稱，你可以新增config/locales/events.yml內容如下：

  # zh-TW:
  #   activerecord:
  #     attributes:
  #       event:
  #         name: "活動名稱"
  #         description: "描述"
  # 其實，翻譯檔檔名叫events.yml、zh-TW.yml、en.yml什麼都無所謂，重要的是YAML結構中第一層要對應locale的名稱，也就是zh-TW，Rails會載入config/locales下所有的YAML詞彙檔案。

#如何讓使用者可以切換多語系
  # 在 application_controller.rb 中加入:

  before_action :set_locale

  def set_locale
    # 可以將 ["en", "zh-TW"] 設定為 VALID_LANG 放到 config/environment.rb 中
    if params[:locale] && I18n.available_locales.include?( params[:locale].to_sym )
      session[:locale] = params[:locale]
    end
    I18n.locale = session[:locale] || I18n.default_locale
  end

  # 在 View 中可以這樣做:
  # <%= link_to "中文版", :controller => controller.controller_name,
  #              :action => controller.action_name, :locale => "zh-TW"  %>
  # <%= link_to "English", :controller => controller.controller_name,
  #              :action => controller.action_name, :locale => "en" %>

#語系樣板
  # 除了上述一個單字一個單字的翻譯詞彙替換之外，如果樣板內大多是屬於較為靜態的內容，Rails也提供了不同語系可以有不同樣板，你只要將樣板命名加上語系附檔名即可，例如：

  # app/views/pages/faq.zh-TW.html.erb
  # app/views/pages/faq.en.html.erb
  # 如此在英文版的時候就會使用faq.en.html.erb這個樣板，中文版時使用faq.zh-TW.html.erb這個樣板。

#Default local
  #下載 zh-TW.yml http://github.com/svenfuchs/rails-i18n 到 config/locale/ 下，就有預設的 Rails 繁體中文翻譯
  #
  #修改 config/application.rb 的預設語系
  config.i18n.default_locale = "zh-TW"
