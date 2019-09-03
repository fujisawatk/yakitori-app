# capistranoのバージョン固定
lock "~> 3.11.0"

# デプロイするアプリケーション名
set :application, "yakitori-app"

# cloneするgitのレポジトリ
set :repo_url, "git@github.com:fujisawatk/yakitori-app.git"

# deployするブランチ。デフォルトはmaster
set :branch, 'master'

# deploy先のディレクトリ。 
set :deploy_to, "/var/www/rails/yakitori-app"

# シンボリックリンクをはるファイル。
set :linked_files, fetch(:linked_files, []).push("config/master.key")

# シンボリックリンクをはるフォルダ。
set :linked_dirs, fetch(:linked_dirs, []).push("log", "tmp/pids", "tmp/cache", "tmp/sockets","vender/bundle", "public/system")


# プロセス番号を記載したファイルの場所
set :unicorn_pid, -> { "#{shared_path}/tmp/pids/unicorn.pid" }

# Unicornの設定ファイルの場所
set :unicorn_config_path, -> { "#{current_path}/config/unicorn.rb" }

# 保持するバージョンの個数
set :keep_releases, 5

#出力するログのレベル。
set :log_level, :debug

# rubyのバージョン
set :rbenv_ruby, '2.5.1'

# デプロイ処理が終わった後、Unicornを再起動するための記述
after 'deploy:publishing', 'deploy:restart'
namespace :deploy do
  task :restart do
    invoke 'unicorn:restart'
  end
end
