namespace :load do
  task :defaults do
    lock '3.4.0'

    set :deploy_to,             -> { "/home/#{fetch(:user)}/projects/#{fetch(:application)}" }
    set :unicorn_config_path,   -> { "/etc/unicorn/#{fetch(:application)}.#{fetch(:login)}.rb" }
    set :unicorn_pid,           -> { "/var/run/unicorn/#{fetch(:user)}/#{fetch(:application)}.#{fetch(:login)}.pid" }
    set :sidekiq_pid,           "#{fetch(:deploy_to)}/shared/tmp/pids/sidekiq-0.pid"
    set :bundle_without,        [:development, :test, :console, :doc]
    set :use_sudo,              false

    ask :branch,                proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

    set :scm,                   :git
    set :format,                :pretty
    set :pty,                   true

    set :log_level,             :info
    set :keep_releases,         5
    set :env, worker_count:     8

    set :linked_files,          fetch(:linked_files, []) + %w(config/database.yml config/application.yml config/newrelic.yml)
    set :linked_dirs,           fetch(:linked_dirs, []) + %w(bin log tmp/cache tmp/pids tmp/sockets vendor/bundle public/system)

    set :default_environments,  'RAILS_ENV=production'
    set :production_rake,       "rvm use #{fetch(:rvm_ruby_version)} do bundle exec rake #{fetch(:default_environments)}"
    set :rake,                  "rvm use #{fetch(:rvm_ruby_version)} do bundle exec rake"
    set :bundle_cmd,            "rvm use #{fetch(:rvm_ruby_version)} do bundle"

    set :assets_roles,          [:web, :app, :db]

    set :sidekiq_start_cmd,     "cd #{fetch(:deploy_to)}/current; #{fetch(:bundle_cmd)} exec sidekiq " \
                                '--index 0 -C config/sidekiq.yml --environment production --daemon'
    set :sidekiq_stop_cmd,      "kill -QUIT `cat #{fetch(:sidekiq_pid)}`"

    after 'deploy:publishing',  'unicorn:restart'
  end
end
