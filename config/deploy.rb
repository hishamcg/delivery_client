require 'bundler/capistrano'
require 'capistrano/ext/multistage'

set :application, "delivery_client"
set :repository,  "git@github.com:hishamcg/delivery_client.git"
set :branch, "master"
set :deploy_via, :remote_cache
set :scm, :git

ssh_options[:paranoid] = false
ssh_options[:forward_agent] = true
set :scm_username, 'hishamcg'
set :use_sudo, false

set :normalize_asset_timestamps, false

set :stages, ["staging", "production"]
set :default_stage, "staging"
