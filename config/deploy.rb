set :application, "doogenfind.net"
set :repository,  "."


set :user, "macdougal79"
set :deploy_to, "/home/#{user}/#{application}"
set :use_sudo, false


set :scm, :git
set :deploy_via, :copy
set :copy_remote_dir, "/home/#{user}"



role :web, application                          # Using Peepcode advice of application here
role :app, application                          # Using Peepcode advice of application here
role :db,  application, :primary => true # This is where Rails migrations will run
role :db,  application

# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reapear helper you will need
# these http://github.com/rails/irs_process_scripts

# Using Peepcode advice here

namespace :deploy do
  desc "Restarting mod_rails with restart.txt"
  task :restart, :roles => :app, :except => { :no_release => true } do
      run "touch #{current_path}/tmp/restart.txt"
    end
    
    [:start, :stop].each do |t|
      desc "#{t} task is a no-op with mod_rails"
      task t, :roles => :app do ; end
    end
  end