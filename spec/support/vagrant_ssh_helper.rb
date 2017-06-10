# -*- encoding : utf-8 -*-
require 'socket'
require 'timeout'

module VagrantSshHelper
  def vagrant_ssh(str)
    old_term = ENV['TERM']

    sleep 1
    ENV['TERM'] = 'xterm'
    ret = VagrantWrapper.new.get_output(['ssh', '-c', "\"#{str}\""]).gsub("\r\n", "\n")

    ENV['TERM'] = old_term
    ret
  end

  def vagrant_check_port_open(port)
    expect(is_vagrant_port_open?(port)).to be_truthy
  end

  def vagrant_check_port_closed(port)
    expect(is_vagrant_port_open?(port)).to be_falsey
  end

  private

  def is_vagrant_port_open?(port)
    vagrant_ssh("sudo iptables -nL") =~ /ACCEPT .*tcp dpt:#{port}\s*$/
  end
end
