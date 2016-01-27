directory '/opt/rletters/root'
rackup 'config.ru'

daemonize
pidfile '/opt/rletters/state/puma.pid'
state_path '/opt/rletters/state/puma.state'

bind 'unix:///opt/rletters/root/tmp/sockets/puma.sock'

workers 2
threads 0, 5

preload_app!

environment 'production'

on_worker_boot do
  # Worker specific setup for Rails 4.1+
  ActiveRecord::Base.establish_connection
end
