#Observer(觀察者)是一種常見的設計模式，可以讓你可以針對Model 的生命週期中的某些階段做出對應的行為，
#例如你想在使用者註冊完帳號的時寄送一封確認信給他，這時候你就可以註冊一個觀察者來觀察User Model，當User建立成功的時候便寄送Email。

#需要安裝rails-observers來啟用這個功能，然後使用generator來建立Observer：
# $ rails generate observer user
#     invoke  active_record
#     create    app/models/user_observer.rb
#     invoke    rspec
#     create      spec/models/user_observer_spec.rb

# 建立好後需要在config/application.rb中註冊這個觀察者：
config.active_record.observers = :user_observer

#在所建立的觀察者類別中，撰寫需要觸發的行為，例如：
class PageObserver < ActiveRecord::Observer
  observe :user

  def after_save(user)
    UserMailer.registration_confirmation(user).deliver # 寄送註冊確認信給 user
  end
end

#一個Observer中也可同時觀察多個不同的Model:
class ContentObserver < ActiveRecord::Observer
    observe :article, :comment

    def update_update(record)
      # do something
    end
end

#Observer支援的觸發條件，和Callback所定義的七種觸發條件是相同的，詳見ActiveRecord 資料驗證及回呼 中的回呼一節
#
#與Callback不同的地方是，Observer通常是設計來做所觀察的Model以外的行為，
#例如在我們的例子中我們觀察了User，而在觸發的行為我們呼叫了其他類別的方法(UserMailer)，
#這不屬於User Model的責任範圍，因此在應用上我們會將自己Model責任範圍內的行為使用Callback，像是資料驗證或是更新。
#本身責任範圍外的行為則使用Observer，像是寄送Email或是呼叫背景處理等。
