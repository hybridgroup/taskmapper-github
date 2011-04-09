#require YOUR_PROVIDER_API
require 'hybridgroup-octokit'

%w{ github ticket project comment }.each do |f|
  require File.dirname(__FILE__) + '/provider/' + f + '.rb';
end
