# in initializers/recaptcha.rb
Recaptcha.configure do |config|
  config.public_key  = '6Lf2Gg0TAAAAABLJIsLJurC283yZTGfatQryxczv'
  config.private_key = '6Lf2Gg0TAAAAAJtRZRM6BqbMbfDkFzqguLOvMyAE'
  # Uncomment the following line if you are using a proxy server:
  # config.proxy = 'http://myproxy.com.au:8080'
  # Uncomment if you want to use the newer version of the API,
  # only works for versions >= 0.3.7:
  config.api_version = 'v2'
end

# in controller
def create
    @sell_iphone = SellIphone.new(sell_iphone_params)
    #if verify_recaptcha(model:@sell_iphone, :message => "'我不是機器人' 有問題!") and @sell_iphone.save
    if @sell_iphone.save
      flash[:success] = "success"
      redirect_to sell_iphone_url(@sell_iphone)
    else
      flash.delete(:recaptcha_error)
      render :action => :new
    end
end

#then in any form view
<%= recaptcha_tags %>
