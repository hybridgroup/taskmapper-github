$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'rubygems'
require 'ticketmaster'
require 'active_support/core_ext/string'
require 'spec'
require 'ticketmaster-github'
require 'vcr'
require 'vcr_setup'

Dir["#{File.dirname(__FILE__)}/factories/*.rb"].each {|f| require f} 
  Spec::Runner.configure do |config|
end
