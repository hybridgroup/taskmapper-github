#require YOUR_PROVIDER_API
require File.dirname(__FILE__) + '/github/github-api'

%w{ github ticket project comment }.each do |f|
  require File.dirname(__FILE__) + '/provider/' + f + '.rb';
end
