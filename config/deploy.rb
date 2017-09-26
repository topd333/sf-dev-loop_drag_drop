# config valid only for current version of Capistrano
lock '3.3.5'

set :application, 'soportal'
set :repo_url, 'git@24.137.55.14:/home/git/soportal.git'
set :rbenv_ruby, '2.2.0'

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, '/var/www/portal'

# Default value for :scm is :git
set :scm, :git
set :branch, "production"

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')

# Default value for linked_dirs is []
# set :linked_dirs, fetch(:linked_dirs, []).push('bin', 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

namespace :deploy do

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

end

namespace :info do
	desc "Print Environment Variables"
	task :printenv do
		on roles(:app) do
			execute "printenv"
		end
	end
end

namespace :setup do
  desc "Upload database.yml file."
  task :upload_database_yml do
    on roles(:app) do
      execute "mkdir -p #{shared_path}/config"
      upload! StringIO.new(File.read("config/deploy/database.yml")), "#{shared_path}/config/database.yml"
    end
  end

  desc "Upload secrets.yml file."
  task :upload_secrets_yml do
    on roles(:app) do
      execute "mkdir -p #{shared_path}/config"
      upload! StringIO.new(File.read("config/deploy/secrets.yml")), "#{shared_path}/config/secrets.yml"
    end
  end
end

namespace :rails do
  desc 'Open a rails console `cap [staging] rails:console [server_index default: 0]`'
  task :console do
    on roles(:app) do |server|
      server_index = ARGV[2].to_i

      return if server != roles(:app)[server_index]

      puts "Opening a console on: #{host}...."

      cmd = "ssh #{server.user}@#{host} -t 'cd #{fetch(:deploy_to)}/current && RAILS_ENV=#{fetch(:rails_env)} bundle exec rails console'"

      puts cmd

      exec cmd
    end
  end
end
