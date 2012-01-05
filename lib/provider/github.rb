module TicketMaster::Provider
  # This is the Github Provider for ticketmaster
  module Github
    include TicketMaster::Provider::Base

    class << self
      attr_accessor :login, :api, :user_token, :valid_user
    end
    
    # This is for cases when you want to instantiate using TicketMaster::Provider::Github.new(auth)
    def self.new(auth = {})
      TicketMaster.new(:github, auth)
    end
    
    # declare needed overloaded methods here
    def authorize(auth = {})
      @authentication ||= TicketMaster::Authenticator.new(auth)
      auth = @authentication
      login = auth.login || auth.username
      if auth.login.blank? and auth.username.blank?
        raise TicketMaster::Exception.new('Please provide at least a username')
      elsif auth.token
        TicketMaster::Provider::Github.login = login
        TicketMaster::Provider::Github.user_token = auth.token
        TicketMaster::Provider::Github.api = Octokit::Client.new(:login => login, :token => auth.token)
      elsif auth.password
        TicketMaster::Provider::Github.login = login
        TicketMaster::Provider::Github.user_token = auth.token
        TicketMaster::Provider::Github.api = Octokit::Client.new(:login => login, :password => auth.password)
      else 
        TicketMaster::Provider::Github.login = login
        TicketMaster::Provider::Github.user_token = nil
        TicketMaster::Provider::Github.api = Octokit::Client.new(:login => login)
      end
    end

    def valid?
      begin
        TicketMaster::Provider::Github.valid_user = TicketMaster::Provider::Github.api.user.total_private_repos >= 0
      rescue
        false
      end
    end

    def projects(*options)
      Project.find(options)
    end

    def project(*project)
      unless project.empty?
        Project.find_by_id(project.first)
      else
        super
      end
    end

  end
end


