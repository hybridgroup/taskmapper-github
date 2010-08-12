$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'rubygems'
require 'ticketmaster'
require 'ticketmaster-github'
require 'spec'
require 'factory_girl'

Dir["#{File.dirname(__FILE__)}/factories/*.rb"].each {|f| require f} 
  Spec::Runner.configure do |config|
end