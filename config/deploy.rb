# capistranoのバージョン固定
lock "~> 3.11.0"

# デプロイするアプリケーション名
set :application, "yakitori-app"

# cloneするgitのレポジトリ
set :repo_url, "git@github.com:fujisawatk/yakitori-app.git"

# deployするブランチ。デフォルトはmaster
set :branch, 'master'

# deploy先のディレクトリ。 
set :deploy_to, "/var/www/yakitori-app"

# シンボリックリンクをはるファイル。
set :linked_files, fetch(:linked_files, []).push("config/master.key")

# シンボリックリンクをはるフォルダ。
set :linked_dirs, fetch(:linked_dirs, []).push("log", "tmp/pids", "tmp/cache", "tmp/sockets","vender/bundle", "public/system")


# プロセス番号を記載したファイルの場所
set :unicorn_pid, -> { "#{shared_path}/tmp/pids/unicorn.pid" }

# Unicornの設定ファイルの場所
set :unicorn_config_path, -> { "#{current_path}/config/unicorn/production.rb" }

# 保持するバージョンの個数
set :keep_releases, 5

#出力するログのレベル。
set :log_level, :debug

# rubyのバージョン
set :rbenv_ruby, '2.5.1'

namespace :deploy do
  desc 'Restart application'
  task :restart do
    invoke 'unicorn:restart'
  end

  desc 'Create database'
  task :db_create do
    on roles(:db) do |host|
      with rails_env: fetch(:rails_env) do
        within current_path do
          execute :bundle, :exec, :rake, 'db:create'
        end
      end
    end
  end

  desc 'Run seed'
  task :seed do
    on roles(:app) do
      with rails_env: fetch(:rails_env) do
        within current_path do
          execute :bundle, :exec, :rake, 'db:seed'
        end
      end
    end
  end

  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
    end
  end
end
