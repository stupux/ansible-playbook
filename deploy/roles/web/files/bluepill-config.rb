# -*- encoding : utf-8 -*-
ENV['RAILS_ENV'] = 'production'

# Whenever this file is updated, make sure to update bluepill-initscript.sh!

Bluepill.application('rletters') do |app|

  app.uid = app.gid = 'rletters_deploy'

  app.process('puma') do |proc|
    proc.start_command = 'bin/puma -C /opt/bluepill/puma.rb'
    proc.stop_command = 'kill -INT {{PID}}'
    proc.restart_command = 'kill -USR2 {{PID}}'

    proc.pid_file = '/opt/bluepill/puma.pid'
    proc.working_dir = '/opt/rletters/root'

    proc.start_grace_time = 60
    proc.stop_grace_time = 60
    proc.restart_grace_time = 180
  end

  app.process('resque-scheduler') do |proc|
    proc.start_command = 'bin/rake RAILS_ENV=production resque:scheduler'
    proc.stop_command = 'kill -QUIT {{PID}}'
    proc.stdout = proc.stderr = '/opt/rletters/root/log/resque-scheduler.log'

    proc.pid_file = '/opt/bluepill/resque-scheduler.pid'
    proc.daemonize = true
    proc.working_dir = '/opt/rletters/root'

    proc.start_grace_time = 60
    proc.stop_grace_time = 60
    proc.restart_grace_time = 60
  end

  app.process('resque-pool') do |proc|
    proc.start_command = 'bin/resque-pool --config /opt/bluepill/resque-pool.yml --daemon --environment production --pidfile /opt/bluepill/resque-pool.pid'
    proc.stop_command = 'kill -QUIT {{PID}}'
    proc.restart_command = 'kill -HUP {{PID}}'

    proc.pid_file = '/opt/bluepill/resque-pool.pid'
    proc.working_dir = '/opt/rletters/root'

    proc.start_grace_time = 60
    proc.stop_grace_time = 60
    proc.restart_grace_time = 180
  end

end
