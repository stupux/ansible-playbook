# -*- encoding : utf-8 -*-
require 'rubygems'
require 'fileutils'
require 'vagrant-wrapper'

VagrantWrapper.require_or_help_install('>= 1.2')

Dir['./spec/support/**/*.rb'].each { |f| require f }

RSpec.configure do |config|
  config.color = true
  config.tty = true
  config.formatter = 'documentation'
  config.order = 'random'

  # Add helpers for dealing with Vagrant
  config.include VagrantSshHelper
end
