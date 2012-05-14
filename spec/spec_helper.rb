$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'rubygems'
require 'taskmapper'
require 'active_support/core_ext/string'
require 'rspec'
require 'taskmapper-github'
require 'fakeweb'

RSpec.configure do |config|
  config.color_enabled = true
end

FakeWeb.allow_net_connect = false

def fixture_file(filename)
  return '' if filename == ''
  file_path = File.expand_path(File.dirname(__FILE__) + '/fixtures/' + filename)
  File.read(file_path)
end


def stub_request(method, url, filename, status=nil)
  options = {:body => ""}
  options.merge!({:body => fixture_file(filename)}) if filename
  options.merge!({:body => status.last}) if status
  options.merge!({:status => status}) if status

  FakeWeb.register_uri(method, url, options) 
end

def stub_get(*args); stub_request(:get, *args) end
def stub_post(*args); stub_request(:post, *args) end
def stub_delete(*args); stub_request(:delete, *args) end
