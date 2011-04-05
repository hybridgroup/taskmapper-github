#require YOUR_PROVIDER_API
require 'octokit'

%w{ github }.each do |f|
  require File.dirname(__FILE__) + '/github/' + f + '.rb';
end

%w{ github ticket project comment }.each do |f|
  require File.dirname(__FILE__) + '/provider/' + f + '.rb';
end
