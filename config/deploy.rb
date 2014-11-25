set :application, "FingerFight"
set :repository,  "git@github.com:xxd/ff.git"

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
set :deploy_to, "/prod/ff"

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
# set :scm, :subversion
set :scm, :git
set :user, "deploy_user"
set :scm_passphrase, "deploy_user"
set :use_sudo, false
set :rails_env, "production"
set :deploy_via, :copy
set :ssh_options, { :forward_agent => true, :port => 4321 }
set :keep_releases, 5
default_run_options[:pty] = true

task :production do
  set  :rails_env,   :production
  role :web,        "106.187.101.82"                         # Your HTTP server, Apache/etc
  role :app,        "106.187.101.82"                         # This may be the same as your `Web` server
  role :db,         "106.187.101.82", :primary => true       # This is where Rails migrations will run
  set  :user,        "deploy_user"
  set  :password,    "deploy_user"
  set  :branch,      "master"
  after "deploy", "sitemap:copy_old_sitemap"
  after "deploy:restart", "rapns:reload"
  puts " Deploying \033[1;41m  production... \033[0m"
end