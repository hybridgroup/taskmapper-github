require 'bundler/setup'
require 'octokit'
require 'active_support/core_ext/string'
require 'net/http'

%w{ github ticket project comment }.each do |f|
  require File.dirname(__FILE__) + '/provider/' + f + '.rb';
end
