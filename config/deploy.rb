require 'bundler/capistrano'
require 'capistrano-unicorn'
require "dotenv/capistrano"

# You can configure your Rails
# app to use this deployment recipe by doing the following:
#
# 1. Add `gem 'capistrano', '~> 2.15'` to your Gemfile.
# 2. Run `bundle install --binstubs --path=vendor/bundles`.
# 3. Run `bin/capify .` in your app's root directory.
# 4. Replace your new config/deploy.rb with this file's contents.
# 5. Configure the two parameters in the Configuration section below.
# 6. Run `bin/cap deploy`.
#
# Note: You may also need to add your local system's public key to
# your GitHub repository's Admin / Deploy Keys area.
#
# Note: When deploying, you'll be asked to enter your server's root
# password. To configure password-less deployments, see below.

#############################################
##                                         ##
##              Configuration              ##
##                                         ##
#############################################

GITHUB_REPOSITORY_NAME = 'wopu'
SERVER_HOSTNAME = '54.235.100.128'

#############################################
#############################################

# General Options

set :default_shell, "/bin/bash -l"
default_run_options[:pty] = true

set :bundle_flags,               "--deployment"

set :application,                "wopu"
set :deploy_to,                  "/opt/www/apps/wopu"
set :normalize_asset_timestamps, false
set :rails_env,                  "production"

set :user,                       "ubuntu"
set :runner,                     "www-data"
set :admin_runner,               "ubuntu"

# Password-less Deploys (Optional)
# Add more keys according developers keys paths
ssh_options[:keys] = ["~/.ssh/wopu-aws.pem"]

# SCM Options
set :scm,        :git
set :repository, "git@github.com:icortex/#{GITHUB_REPOSITORY_NAME}.git"
set :branch,     "master"

# Roles
role :app, SERVER_HOSTNAME
role :db,  SERVER_HOSTNAME, :primary => true

# Add Configuration Files & Compile Assets
after 'deploy:update_code' do
  # Setup Configuration
  run "cp #{shared_path}/config/mongoid.yml #{release_path}/config/mongoid.yml"
  run "cp #{shared_path}/config/unicorn.rb #{release_path}/config/unicorn.rb"

  # Compile Assets
  run "cd #{release_path}; RAILS_ENV=production bundle exec rake assets:precompile"
end

#after 'deploy:restart', 'unicorn:reload'    # app IS NOT preloaded
#after 'deploy:restart', 'unicorn:restart'   # app preloaded
after 'deploy:restart', 'unicorn:duplicate' # before_fork hook implemented (zero downtime deployments)
