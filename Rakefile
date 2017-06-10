#!/usr/bin/env rake
require 'fileutils'

desc 'Bring up a new vagrant VM'
task :up do
  system('vagrant up')
end

desc 'Bring down the vagrant VM'
task :down do
  system('vagrant halt')
  system('vagrant destroy -f')

  # Remove all the password files
  FileUtils.rm_f File.join('.', 'deploy', 'roles', 'db', 'files', 'db_default_pass')
  FileUtils.rm_f File.join('.', 'deploy', 'roles', 'solr', 'files', 'tomcat_default_pass')
  FileUtils.rm_f File.join('.', 'deploy', 'roles', 'web', 'files', 'deploy_default_pass')
end
