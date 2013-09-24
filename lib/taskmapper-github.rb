require 'bundler/setup'

require 'octokit'
require 'active_support/core_ext/string'
require 'net/http'
require 'taskmapper'

require 'provider/github'
require 'provider/project'
require 'provider/ticket'
require 'provider/comment'
require 'provider/version'
