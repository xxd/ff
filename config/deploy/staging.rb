set :stage, :test
set :branch, 'master'

server '106.187.101.82', user: 'deploy_user', roles: %w{web app db}

set :deploy_to, "/prod/FingerFight"

# dont try and infer something as important as environment from
# stage name.
set :rails_env, :test

# number of unicorn workers, this will be reflected in
# the unicorn.rb and the monit configs
set :unicorn_worker_count, 5

# whether we're using ssl or not, used for building nginx
# config file
set :enable_ssl, false