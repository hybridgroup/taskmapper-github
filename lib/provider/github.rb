module TicketMaster::Provider
  # This is the Github Provider for ticketmaster
  module Github
    include TicketMaster::Provider::Base
    PROJECT_API = Octopi::Repository
    
    # This is for cases when you want to instantiate using TicketMaster::Provider::Github.new(auth)
    def self.new(auth = {})
      TicketMaster.new(:github, auth)
    end
    
    # declare needed overloaded methods here
    def authorize(auth = {})
      @authentication ||= TicketMaster::Authenticator.new(auth)
      auth = @authentication
      if auth.token.nil? or auth.login.nil?
        raise "Please provide token and login"
      else
	Octopi::Api.api = Octopi::AuthApi.instance
	Octopi::Api.api.token = auth.token
	Octopi::Api.api.login = auth.login
      end
    end
    
  end
end


