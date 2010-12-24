module TicketMaster::Provider
  # This is the Github Provider for ticketmaster
  module Github
    include TicketMaster::Provider::Base
    PROJECT_API = Octopi::Repository
    ISSUE_API = Octopi::Issue

    class << self
      attr_accessor :login
    end
    
    # This is for cases when you want to instantiate using TicketMaster::Provider::Github.new(auth)
    def self.new(auth = {})
      TicketMaster.new(:github, auth)
    end
    
    # declare needed overloaded methods here
    def authorize(auth = {})
      @authentication ||= TicketMaster::Authenticator.new(auth)
      auth = @authentication
      if auth.token.nil? or (auth.login.nil? and auth.username.nil?)
        TicketMaster::Provider::Github.login = auth.login || auth.username
        return
      else
        Octopi::Api.api = Octopi::AuthApi.instance
        Octopi::Api.api.token = auth.token unless auth.token.blank?
        Octopi::Api.api.login = auth.login || auth.username
      end
    end

    def projects(*options)
      if options.empty?
        PROJECT_API.find(:user => TicketMaster::Provider::Github.login).collect{|repo| Project.new repo}
      elsif  options.first.is_a?(Array)
        options.collect{|name| Project.find(name)}.first
      end
    end
    
    def project(*name)
      unless name.empty?
        Project.find(name.first)
      else
        super
      end
    end
    
  end
end


