class ReturnExampleController < ApplicationController
  #可將Controller中重複的程式抽出來，有三種方法可以定義在進入Action之前、
  #之中或之後執行特定方法，分別是before_action、after_action和around_action，其中before_action最為常用。
  #這三個方法可以接受Code block、一個Symbol方法名稱或是一個物件(Rails會呼叫此物件的filter方法)。

  #Filter的順序
    #當有多個Filter時，Rails是由上往下依序執行的。
    #如果需要加到第一個執行，可以使用
    prepend_before_action  :filter_method_name
    prepend_after_action :filter_method_name
    prepend_around_action :filter_method_name

    #如果需要取消從父類別繼承過來的Filter，可以使用
    skip_before_action :filter_method_name
    skip_after_action :filter_method_name
    skip_around_action :filter_method_name

  #before_action
    #before_action最常用於準備跨Action共用的資料，或是使用者權限驗證等等：
    before_action :find_event, :only => :show
    before_action :find_event, :except => :show
    def show
    end

    protected

    def find_event
      @event = Event.find(params[:id])
    end

  #around_action
    around_action BenchmarkFilter

    # app/controllers/benchmark_filter.rb
    class BenchmarkFilter
        def self.filter(controller)
         timer = Time.now
         Rails.logger.debug "---#{controller.controller_name} #{controller.action_name}"
         yield # 這裡讓出來執行Action動作
         elapsed_time = Time.now - timer
         Rails.logger.debug "---#{controller.controller_name} #{controller.action_name} finished in %0.2f" % elapsed_time
        end
    end

end
