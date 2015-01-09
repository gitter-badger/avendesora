# avendesora
#
# Copyright (c) 2015 Eric Will <rakaur@malkier.net>
# Rights to this code are documented in LICENSE.

class Configuration
  attr_reader :config_file

  def initialize(file = nil)
    @config_file = file

    @config = Object.new
    @config.extend Configuration::DSL
  end

  public

  def parse
    begin
      data = File.read(@config_file)
    rescue Exception => err
      raise Configuration::ParseError
    end

    error = catch(:error) { @config.instance_eval(data) }

    if error.kind_of? Exception
      puts 'ircd: error loading configuration:'
      puts "\t#{error}"

      file = @config_file.split(File::SEPARATOR)[-2 .. -1].join(File::SEPARATOR)
      line = error.backtrace[2].split(':')[2]

      puts "\t\t#{file}:#{line}"

      abort
    end

    @config
  end

  class ParseError < Exception; end
end

module Configuration::DSL
  attr_reader :me

  def daemon(name = "XXX make this required", &block)
    @me = OpenStruct.new
    @me.name = name
    @me.extend Configuration::DSL::Daemon

    begin
      @me.instance_eval &block
    rescue Exception => err
      throw :error, err
    end
  end
end

module Configuration::DSL::Daemon
end
