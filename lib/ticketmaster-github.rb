#require YOUR_PROVIDER_API
require 'octokit'
require 'active_support/core_ext/string'

%w{ github ticket project comment }.each do |f|
  require File.dirname(__FILE__) + '/provider/' + f + '.rb';
end
