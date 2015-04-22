run model
    p = Post.first
run controller
    app.get '/posts/1'
    response = app.response
    response.body
    response.cookies
    OR
    foo = ActionController::Base::ApplicationController.new
    foo.some_method
    run helper
    helper.number_to_currency('123.45')
    OR
    foo = ActionView::Base.new
    foo.javascript_include_tag 'myscript'
run Route Helper
    app.myresource_path
    app.myresource_url
Pry-rails
    In Rails console, the breakpoint will stop at the code called "binding.pry"
    can use continue, step, next or finish to navigate
    setting in ./pryrc
    can also use pry-remote for remote debugging like x-debug in php
    call "binding.remote_pry" and then pry-remote to start console
    basic command
    cd - change the console context to that object such that you dont have to type it again
    ls - list out the method
    q - to exit from the console while showing the text( default using VIM to show data)
    show-doc OR ? Array#map - to show the doc Array#map
    show-method OR $ Array#map - to show the source method
    show-route
    show-model
    wtf? - to see the stack
    play xx.rb - run the file
    awesome_print
    better printing for hash variable
require 'awesome_print' at ./pryrc
in console, "ap <hash or array>"
DevDependencies

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
