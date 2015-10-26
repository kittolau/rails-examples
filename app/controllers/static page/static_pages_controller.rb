class StaticPagesController < ApplicationController
  def home
  end

  def disclaimer

  end
end

#in routes.rb, add the following lines

get "disclaimer" => 'static_pages#disclaimer'
root 'sell_iphones#index'

#in app/views/static_pages
#create view
