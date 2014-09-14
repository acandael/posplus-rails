require 'capistrano-rbenv'

set :application, 'posplus'
set :repo_url, 'git@github.com:acandael/posplus-rails.git'
set :branch, 'capistrano'

set :deploy_to, '/home/deploy/posplus'

set :linked_files, %w{config/database.yml config/secrets.yml}
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, 'deploy:restart'
  after :finishing, 'deploy:cleanup'
end
