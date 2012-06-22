set :user, 'pixelephant'
set :domain, 'vindemiatrix.dreamhost.com'
set :project, 'madearthome'

set :application, "rails.pixelephant.hu"
set :applicationdir, "/home/#{user}/#{application}"  # The standard Dreamhost setup

set :repository,  "git://github.com/pixelephant/madearthome.git"

set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`
set :scm_username, 'pixelephant'
set :scm_password, 'pix3l3phant'

role :web, domain                          # Your HTTP server, Apache/etc
role :app, domain                          # This may be the same as your `Web` server
role :db,  domain, :primary => true # This is where Rails migrations will run
#role :db,  "your slave db-server here"

set :deploy_to, applicationdir
set :deploy_via, :remote_cache
set :branch, 'master'
set :git_shallow_clone, 1
set :scm_verbosem, true

#Additional settings
default_run_options[:pty] = true  # Forgo errors when deploying from windows
#ssh_options[:keys] = %w(/Path/To/id_rsa)            # If you are using ssh_keys
set :chmod755, "app config db lib public vendor script script/* public/disp*"
set :use_sudo, false

# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reapear helper you will need
# these http://github.com/rails/irs_process_scripts
# namespace :deploy do
#   task :start {}
#   task :stop {}
#   task :restart, :roles => :app, :except => { :no_release => true } do
     #run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#			run "#{try} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end

desc "Restarting after deployment"
task :after_deploy, :roles => [:app, :db, :web] do
 run "sed 's/# ENV\\[/ENV\\[/g' #{deploy_to}/current/config/environment.rb > #{deploy_to}/current/config/environment.temp"
 run "mv #{deploy_to}/current/config/environment.temp #{deploy_to}/current/config/environment.rb"
end
