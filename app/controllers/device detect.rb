#透過設定request.variant我們可以提供不同的Template內容，這可以拿來針對不同的客戶端裝置，提供不同的內容，例如利用request.user_agent來區分電腦、手機和平板裝置：

class ApplicationController < ActionController::Base

before_action :detect_browser

private

  def detect_browser
    case request.user_agent
      when /iPad/i
        request.variant = :tablet
      when /iPhone/i
        request.variant = :phone
      when /Android/i && /mobile/i
        request.variant = :phone
      when /Android/i
        request.variant = :tablet
      when /Windows Phone/i
        request.variant = :phone
      else
        request.variant = :desktop
      end
  end
end
