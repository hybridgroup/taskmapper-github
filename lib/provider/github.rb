module TaskMapper::Provider
  # This is the Github Provider for taskmapper
  module Github
    include TaskMapper::Provider::Base

    class << self
      attr_accessor :login, :api, :user_token 
    end
    
    # This is for cases when you want to instantiate using TaskMapper::Provider::Github.new(auth)
    def self.new(auth = {})
      TaskMapper.new(:github, auth)
    end
    
    # declare needed overloaded methods here
    def authorize(auth = {})
      @authentication ||= TaskMapper::Authenticator.new(auth)
      auth = @authentication
      $D =  auth
      login = auth.login || auth.username
      if auth.login.blank? and auth.username.blank?
        raise TaskMapper::Exception.new('Please provide at least a username')
      elsif auth.token
        TaskMapper::Provider::Github.login = login
        TaskMapper::Provider::Github.user_token = auth.token
        TaskMapper::Provider::Github.api = Octokit::Client.new(:login => login, :token => auth.token)
      elsif auth.password
        TaskMapper::Provider::Github.login = login
        TaskMapper::Provider::Github.user_token = auth.token
        TaskMapper::Provider::Github.api = Octokit::Client.new(:login => login, :password => auth.password)
      elsif auth.oauth_token
        TaskMapper::Provider::Github.login = login
        TaskMapper::Provider::Github.user_token = auth.oauth_token
        TaskMapper::Provider::Github.api = Octokit::Client.new(:login => login, :oauth_token => auth.oauth_token)
      else 
        TaskMapper::Provider::Github.login = login
        TaskMapper::Provider::Github.user_token = nil
        TaskMapper::Provider::Github.api = Octokit::Client.new(:login => login)
      end
    end

    def valid?
      TaskMapper::Provider::Github.api.authenticated? || TaskMapper::Provider::Github.api.oauthed?
    end

  end
end


