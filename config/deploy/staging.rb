# # Simple Role Syntax
# # ==================
# # Supports bulk-adding hosts to roles, the primary server in each group
# # is considered to be the first unless any hosts have the primary
# # property set.  Don't declare `role :all`, it's a meta role.

# role :app, %w{deploy@example.com}
# role :web, %w{deploy@example.com}
# role :db,  %w{deploy@example.com}


# # Extended Server Syntax
# # ======================
# # This can be used to drop a more detailed server definition into the
# # server list. The second argument is a, or duck-types, Hash and is
# # used to set extended properties on the server.

# server 'example.com', user: 'deploy', roles: %w{web app}, my_property: :my_value


# # Custom SSH Options
# # ==================
# # You may pass any option but keep in mind that net/ssh understands a
# # limited set of options, consult[net/ssh documentation](http://net-ssh.github.io/net-ssh/classes/Net/SSH.html#method-c-start).
# #
# # Global options
# # --------------
# #  set :ssh_options, {
# #    keys: %w(/home/rlisowski/.ssh/id_rsa),
# #    forward_agent: false,
# #    auth_methods: %w(password)
# #  }
# #
# # And/or per server (overrides global)
# # ------------------------------------
# # server 'example.com',
# #   user: 'user_name',
# #   roles: %w{web app},
# #   ssh_options: {
# #     user: 'user_name', # overrides user setting above
# #     keys: %w(/home/user_name/.ssh/id_rsa),
# #     forward_agent: false,
# #     auth_methods: %w(publickey password)
# #     # password: 'please use keys'
# #   }


server "107.23.108.186", :app, :web, :db, :primary => true
ssh_options[:keys] = ["#{ENV['HOME']}/.ssh/id_rsa"]
set :deploy_to, "/rails/apps/delivery_client"
set :user, 'rails' # server user

set :default_environment, { "PATH" =>
    "/rails/common/ruby-1.9.2-p290/bin:#{deploy_to}/shared/bundle/ruby/1.9.1/bin:$PATH",
    "LD_LIBRARY_PATH" => "/rails/common/oracle/instantclient_11_2",
    "TNS_ADMIN" => "/rails/common/oracle/network/admin" }



namespace :deploy do
  namespace :assets do
    task :precompile, :roles => :web, :except => { :no_release => true } do
      run %Q{cd #{latest_release} && #{rake} RAILS_ENV=#{rails_env} #{asset_env} assets:precompile}
      # from = source.next_revision(current_revision)
      # if releases.length <= 1 || capture("cd #{latest_release} && #{source.local.log(from)} vendor/assets/ app/assets/ | wc -l").to_i > 0
      #   run %Q{cd #{latest_release} && #{rake} RAILS_ENV=#{rails_env} #{asset_env} assets:precompile}
      # else
      #   logger.info "Skipping asset pre-compilation because there were no asset changes"
      # end
    end
  end
  after "deploy:update_code" do
    run "cp #{deploy_to}/shared/database.yml #{release_path}/config/database.yml"
    run "cp #{deploy_to}/shared/delivery_cross_ref.yml #{release_path}/config/delivery_cross_ref.yml"
    run "cp #{deploy_to}/shared/application.yml #{release_path}/config/application.yml"
  end

  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end