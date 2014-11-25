# Load DSL and Setup Up Stages
require 'capistrano/setup'

# Includes default deployment tasks
require 'capistrano/deploy'

# Includes tasks from other gems included in your Gemfile
#
# For documentation on these, see for example:
#
#   https://github.com/capistrano/rvm
#   https://github.com/capistrano/rbenv
#   https://github.com/capistrano/chruby
#   https://github.com/capistrano/bundler
#   https://github.com/capistrano/rails
#
# require 'capistrano/rvm'
require 'capistrano/rbenv' # include the rbenv helpers which ensure the rbenv specified ruby is used when executing commands remotely rather than the system default
# require 'capistrano/chruby'
require 'capistrano/bundler' #Which will include the capistrano bundler tasks to ensure gems are automatically installed when you deploy.
# require 'capistrano/rails/assets'
require 'capistrano/rails/migrations' #inally it will include the migration helpers which ensure migrations are automatically run when you deploy.

# Loads custom tasks from `lib/capistrano/tasks' if you have any defined.
Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }

#This means that as well as loading all .cap files in lib/capistrano/tasks
Dir.glob('lib/capistrano/**/*.rb').each { |r| import r } 