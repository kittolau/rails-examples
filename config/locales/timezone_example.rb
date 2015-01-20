# 時區 TimeZone

  # 首先，資料庫裡面的時間一定都是儲存 UTC 時間。而 Rails 提供的機制是讓你從資料庫拿資料時，自動幫你轉換時區。例如，要設定台北 +8 時區：

  # 首先設定 config/application.rb 中預設時區為 config.time_zone = “Taipei”，如此 ActiveRecord 便會幫你自動轉換時區，也就是拿出來時 +8，存回去時 -8

  # 如何根據使用者切換時區？

  # 首先，你必須找個地方儲存不同使用者的時區，例如 User model 有一個欄位叫做 time_zone:string。然後在編輯設定的地方，可以讓使用者自己選擇時區:

  #  <%= time_zone_select :user, :time_zone %>
  # 接著在 application_controller.rb 中加入:

  # before_action :set_timezone

  # def set_timezone
  #    if logged_in? && current_user.time_zone
  #       Time.zone = current_user.time_zone
  #     end
  # end

#時區處理方法

  # Ruby原生的Time類別對於時區的處理一律是參考唯一的系統環境變數ENV['TZ']，這在使用者多時區的應用程式中就顯的見拙。因此在Rails中的時間類別使用的是ActiveSupport::TimeWithZone，我們已經知道可以使用Time.zone可以改變時區，其他的用法例如：

  # Time.zone = "Taipei"
  # Time.zone.local(2011, 8, 3, 9, 0) # 建立一個Taipei當地時間
  # => Wed, 03 Aug 2011 09:00:00 CST +08:00
  # t = Time.zone.now # 目前時間
  # => Wed, 03 Aug 2011 22:17:54 CST +08:00
  # t.in_time_zone("Tokyo") # 將這個時間換時區
  # => Wed, 03 Aug 2011 23:18:34 JST +09:00
  # Time.utc(2005,2,1,15,15,10).in_time_zone # 將UTC時間換Taipei當地時間
  # => Tue, 01 Feb 2005 23:15:10 CST +08:00

#時間的顯示

  # 除了使用Ruby內建的Datetime#strftime格式化時間之外，Rails也可以直接呼叫to_s轉換輸出格式：

  # datetime.to_s(:db)                      # => "2007-12-04 00:00:00"
  # datetime.to_s(:number)                  # => "20071204000000"
  # datetime.to_formatted_s(:short)         # => "04 Dec 00:00"
  # datetime.to_formatted_s(:long)          # => "December 04, 2007 00:00"
  # datetime.to_formatted_s(:long_ordinal)  # => "December 4th, 2007 00:00"
  # datetime.to_formatted_s(:rfc822)        # => "Tue, 04 Dec 2007 00:00:00 +0000"
  # datetime.to_formatted_s(:iso8601)       # => "2007-12-04T00:00:00+00:00"
  # 也可以自行註冊專案常用的格式在config/initializers/time_formats.rb裡：

  # Time::DATE_FORMATS[:month_and_year] = '%B %Y'
  # Time::DATE_FORMATS[:short_ordinal] = lambda { |time| time.strftime("%B #{time.day.ordinalize}") }
  # 或是透過I18n的機制，在翻譯詞彙檔中編輯格式，然後使用：

  # I18n.l( Time.now )
  # I18n.l( Time.now, :format => :short )
