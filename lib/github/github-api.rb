require 'rubygems'
require 'active_support'
require 'active_resource'
require 'octopi'

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
  #   # => true
  #
  # Creating an OSS project
  # 
  #   project = LighthouseAPI::Project.new(:name => 'OSS Project')
  #   project.access = 'oss'
  #   project.license = 'mit'
  #   project.save
  # 
  # OSS License Mappings
  # 
  #   'mit' => "MIT License",
  #   'apache-2-0' => "Apache License 2.0",
  #   'artistic-gpl-2' => "Artistic License/GPLv2",
  #   'gpl-2' => "GNU General Public License v2",
  #   'gpl-3' => "GNU General Public License v3",
  #   'lgpl' => "GNU Lesser General Public License"
  #   'mozilla-1-1' => "Mozilla Public License 1.1"
  #   'new-bsd' => "New BSD License",
  #   'afl-3' => "Academic Free License v. 3.0"
  
  #
  # Updating a Project
  #
  #   project = LighthouseAPI::Project.find(44)
  #   project.name = "Lighthouse Issues"
  #   project.public = false
  #   project.save
  #
  # Finding tickets
  # 
  #   project = LighthouseAPI::Project.find(44)
  #   project.tickets
  #
  class Project < Base
    def tickets(options = {})
      Ticket.find(:all, :params => options.update(:project_id => id))
    end
  end
end