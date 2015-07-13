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

  # FIXME: Soon, ActiveJob will stop using named queues to manage Que jobs, and
  # this will just collapse to a single queue. We will then need to use
  # priorities and multiple workers, or something.
  %w(ui maintenance analysis).each do |queue|
    app.process("que-queue-#{queue}") do |proc|
      proc.start_command = "bin/rake RAILS_ENV=production QUE_QUEUE=#{queue} QUE_WORKER_COUNT=1 que:work"
      proc.stdout = proc.stderr = "/opt/rletters/root/log/que-queue-#{queue}.log"

      proc.pid_file = "/opt/bluepill/que-queue-#{queue}.pid"
      proc.dameonize = true
      proc.working_dir = '/opt/rletters/root'

      proc.start_grace_time = 60
      proc.stop_grace_time = 60
      proc.restart_grace_time = 60
    end
  end

end
