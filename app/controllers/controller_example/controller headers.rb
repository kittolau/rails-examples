  class ExampleController < ApplicationController
  #response
    #代表要回傳的內容，會由Rails設定好。通常你會用到的時機是你想加特別的Response Header。
    #add custom HTTP header
    response.headers['HEADER NAME'] = 'HEADER VALUE'
  end
