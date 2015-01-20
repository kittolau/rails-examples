class MailerExample < ActionMailer::Base
  default from: "from@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.mailer_example.textAction.subject
  #
  def textAction(email)
    @greeting = "Hi"

    mail to: email, subject: "email_title"
  end

#   舉凡使用者註冊認證信、忘記密碼通知信、電子報、各種訊息通知，E-mail寄送都是現代網站必備的一項功能。Rails的ActionMailer元件提供了很方便的Email整合。

# ActionMailer設定

# Rails在config/environments目錄下針對不同執行環境會有不同的郵件伺服器設定：

# config.action_mailer.delivery_method
# 支援的選項包括:test、:sendmail和smtp。在config/environments/test.rb中，預設是:test，也就是並不會實際寄信，而是將信件存在ActionMailer::Base.deliveries陣列中方便做功能測試。sendmail則是使用伺服器的/usr/bin/sendmail程式，不過因為因為不是每台伺服器都有適當安裝sendmail，所以最推薦的方式是採用:smtp協定來寄信，例如以下是一個使用Gmail寄信的範例，請修改config/environments/development.rb或config/environments/production.rb：

# config.action_mailer.delivery_method = :smtp
# config.action_mailer.default_url_options = { host: "http://localhost:3000" }
# config.action_mailer.smtp_settings = {
#     :address => "smtp.gmail.com",
#     :port => "587",
#     :domain => "gmail.com",
#     :authentication => "plain",
#     :user_name => "example@gmail.com",
#     :password => "123456",
#     :enable_starttls_auto => true
#  }
# 其中default_url_options設定是因為在Email這個情境下，如果要在Email中放超連結，必須是絕對網址。所以我們必須設定網站的網址。

# 建立一個Mailer寄信程式

# 和Controller一樣，Rails也用generate指令產生Mailer類別，此類別中的一個方法就對應一個Email樣板。以下是一個產生Mailer的範例：

# rails generate mailer UserMailer confirm
# 如此便會產生app/mailers/user_mailer.rb檔案，並包含一個confirm的動作，其template在app/views/user_mailer/confirm.text.erb(純文字格式)和 confirm.html.erb(HTML格式)。如果兩種格式的樣板檔案都有，那麼Rails會合併成一封Multiple Content Types的Email。

# 讓我們看看 user_mailer.rb 的程式：

# class UserMailer < ActionMailer::Base
#     default :from => "foobar@example.org"

#     def confirm(email)
#         @message = "Thank you for confirmation!"
#         mail(:to => email, :subject => "Registered")
#     end
# end
# 其中default方法可以設定預設的寄件人。而 mail 方法可以設定收件人和郵件主旨。和View一樣，@user物件變數可以在app/views/user_mailer/confirm.text.erb或app/views/user_mailer/confirm.html.erb或樣板中存取到。而mail方法則還可以接受其他參數包括cc、bcc。

# 我們可以在rails console中測試，執行UserMailer.confirm("someone@example.org").deliver就會寄信出去。

# 實務上，我們會在controller之中，例如使用者註冊之後寄發信件：

# def create
#     user = User.new(params[:user])
#     if user.save
#         UserMailer.confirm(user.email).deliver
#         redirect_to users_path
#     else
#         render :action => :new
#     end
# end
# 如果只需要純文字版，就砍掉app/views/user_mailer/confirm.html.erb這個檔案，然後在app/views/user_mailer/confirm.text.erb純文字格式中，可以加入以下文字跟網址：

# 歡迎在 <%= url_for(root_url) %> 註冊！
# 另外，因為寄信這個動作比較耗時，通常我們也會搭配使用非同步的機制，詳見非同步處理一章。

# 第三方SMTP服務

# 由於Gmail是個人用途使用，用量有限，並不適合開站做生意使用。我們實務上我們會使用第三方服務來確保Email遞送的可靠性，例如：

# mailgun
# SendGrid
# Postmark
# MailChimp
# AWS SES
# 大量寄送 Email 會是一門學問，請參考 如何正確發送(大量) Email 信件 這篇文章
# 開發預覽

# 開發期間我們需要常常測試預覽寄出的Email內容，但是實際寄送出去又很沒效率。我們可以安裝letter_opener這個gem，修改Gemfile加入：

# gem "letter_opener", :group => :development
# 然後將config.action_mailer.delivery_method改成:letter_opener

# 這樣在開發模式下，就會開瀏覽器進行預覽，而不會真的寄信出去。

# 收信

# Active Mailer也可以辦到收信，請參考：

# Receiving Incoming Email in Rails 3
# Receiving Email with Rails
# Stress-free Incoming E-Mail Processing with Rails
# 或是使用第三方服務，例如MailChimp有提供收信的Webhook服務：信寄到MailChimp服務，然後Mailchimp再呼叫網站的HTTP API。
end
