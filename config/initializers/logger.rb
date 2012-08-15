require 'log4r'
require 'log4r/yamlconfigurator'
require 'log4r/outputter/datefileoutputter'
require 'log4r/outputter/fileoutputter'
require 'log4r/outputter/emailoutputter'
require 'log4r/outputter/udpoutputter'
require 'log4r/formatter/log4jxmlformatter'

# set rails paths and logger config.
Log4r::YamlConfigurator['RAILS_ROOT'] = RAILS_ROOT
Log4r::YamlConfigurator['RAILS_ENV']  = RAILS_ENV
Log4r::YamlConfigurator.load_yaml_file(File.join(CONFIG_ROOT, 'log4r.yml'))

# create the default logger.
RAILS_DEFAULT_LOGGER = Log4r::Logger['default'] unless defined?(RAILS_DEFAULT_LOGGER)
RAILS_DEFAULT_LOGGER.level = ((['development', 'staging'].include?(RAILS_ENV)) ? Log4r::DEBUG : Log4r::INFO)

case RAILS_ENV
when 'production'
  udp_out = Log4r::UDPOutputter.new 'udp', :hostname => 'loghost', :port => 2552
  udp_out.level = Log4r::ERROR # Turn UDP outputter on for prod
  RAILS_DEFAULT_LOGGER.outputters << udp_out
  Log4r::Outputter['stdout'].level = Log4r::OFF        # Turn std outputters off in prod
  Log4r::Outputter['stderr'].level = Log4r::OFF
when 'development'
  Log4r::Outputter['datefilelog'].level = Log4r::OFF   # Turn datefile outputter off in dev (it'll just clutter your workspace)
else
  Log4r::Outputter['stdout'].level = Log4r::OFF        # Turn std outputters off except in dev
  Log4r::Outputter['stderr'].level = Log4r::OFF
end

# Give objects access to logger.
class Object
  def logger name = nil
    self.class.logger(name)
  end
  alias_method :log, :logger

  class << self
    def logger name = nil
      (name && Log4r::Logger[name]) || RAILS_DEFAULT_LOGGER
    end
    alias_method :log, :logger
  end
end
