Rails c

#run model
    p = Post.first
#run controller
    app.get '/posts/1'
    response = app.response
    response.body
    response.cookies
    #OR
    foo = ActionController::Base::ApplicationController.new
    foo.some_method
#run helper
    helper.number_to_currency('123.45')
    #OR
    foo = ActionView::Base.new
    foo.javascript_include_tag 'myscript'
#run Route Helper
    app.myresource_path
    app.myresource_url
#Pry-rails
    #setting is located in ./pryrc

    #In Rails console, the breakpoint will stop at the code called "binding.pry"
    #can use the followings  to navigate during debug
        continue
        step
        next
        finish


    #can also use pry-remote for remote debugging like x-debug in php
    #call "binding.remote_pry" and then pry-remote to start console

    #basic command
        #change the console context to that object such that you dont have to type it again
        cd
        #list out the method
        ls
        #to exit from the console while showing the text( default using VIM to show data)
        q
        #to show the doc Array#map
        show-doc Array#map
        #OR
        ? Array#map
        #to show the source method
        show-method
        #OR
        $ Array#map
        #list out route
        show-route
        #list out model schema
        show-model
        #to see the stack
        wtf?
        #run the file
        play xx.rb
        #awesome_print
            #better printing for hash variable
            #require 'awesome_print' at ./pryrc
            #then in rails console,
            ap <hash or array>

#Dev Dependencies for debugging
group :development do
    #an IRB replacement
    gem 'pry'
    #getting pry in Rails console to replace IRB
    #can also use "show-routes --grep new", "show-models" in the console
    gem 'pry-rails'
    #Adds step, next, finish and continue commands and breakpoints to Pry using byebug. Only supoort Ruby 2+
    gem 'pry-byebug'
    #adding support for remote debugging
    gem 'pry-remote'
    #gem 'pry-stack_explorer'

    #better printing
    gem 'awesome_print'
end
