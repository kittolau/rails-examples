#capistrano run taskes on server via SSH
  #basic coding

  #set default run option
    default_run_options[:pty] = true

  #set value and
    set :custom_val, "abc"

  #get value
    "#{application}"
    fectch(:custom_val,"default value")

  #run command
    run "echo 1"
    #run as sudo
    run "#{sudo} apt-get update"

  #define the server and the role for the server
    server "72.14.183.209", :web, :app, :db, primary: true
    #role means the taskes that executed for certain role will be executed on those servers
    #common roles are
      :web #web server
      :app #rails app
      :db #database
    #:db, primary: true means the master of the database cluster

  #load file
    load "config/recipes/nginx"

  #define task
    #run the in command , cap hello
    task :hello do
      puts "hello world"
    end
    #task for specific role
    task :hello, roles: :db  do
      puts "hello world"
    end

    #define multiple task
    %w[start stop restart].each do |command|
      #meta function to desc the task
      desc "#{command} nginx"
      task command, roles: :web do
        run "#{sudo} service nginx #{command}"
      end
    end

  #call task
    task :goodby do
      hello #call hello task
      puts "Goodbye World"
    end
    #OR
    after :goodby, :hello

    #after on role
    after :restart, :clear_cache do
      on roles(:web), in: :groups, limit: 3, wait: 10 do
        # Here we can do anything such as:
        # within release_path do
        #   execute :rake, 'cache:clear'
        # end
      end
    end

  #namespace
    namespace :deploy do
      #run the in command , cap deploy:hello
      task :hello do
        puts "hello world"
      end
    end

  #put file into server
    put ERB.new(erb).result(binding), to #the put method provided by capistrano to put file into the "to" localtion

