require 'rubygems'
require 'active_support'
require 'active_resource'

module GithubApi
  class Error < StandardError; end
    
  class << self
    attr_accessor :login, :token
    
    def authenticate(login)
      @login = login
      self::Base.user = login
    end
    
    def token=(value)
      @token = value
    end
  end
  
  
  class Base < ActiveResource::Base
    def self.inherited(base)
      class << base; end
      super
    end
  end
end