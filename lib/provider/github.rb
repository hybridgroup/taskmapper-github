module TicketMaster::Provider
  # This is the Github Provider for ticketmaster
  module Github
    include TicketMaster::Provider::Base
    PROJECT_API = Github::Project
    ISSUE_API = Github::Ticket

    class << self
      attr_accessor :login, :api
    end
    
    # This is for cases when you want to instantiate using TicketMaster::Provider::Github.new(auth)
    def self.new(auth = {})
      TicketMaster.new(:github, auth)
    end
    
    # declare needed overloaded methods here
    def authorize(auth = {})
      @authentication ||= TicketMaster::Authenticator.new(auth)
      auth = @authentication
      if auth.login.blank? and auth.username.blank?
        raise TicketMaster::Exception.new('Please provide at least a username')
      elsif auth.token.blank?
        TicketMaster::Provider::Github.login = auth.login || auth.username
        TicketMaster::Provider::Github.api = Octokit.client(:login => auth.login)
      else
        TicketMaster::Provider::Github.login = auth.login || auth.username
        TicketMaster::Provider::Github.api = Octokit.client(:login => auth.login, :token => auth.token)
      end
    end
  end
end


