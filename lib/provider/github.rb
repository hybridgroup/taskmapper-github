module TaskMapper::Provider
  # This is the Github Provider for taskmapper
  module Github
    include TaskMapper::Provider::Base

    class << self
      attr_accessor :login, :api, :user_token, :valid_user
    end
    
    # This is for cases when you want to instantiate using TaskMapper::Provider::Github.new(auth)
    def self.new(auth = {})
      TaskMapper.new(:github, auth)
    end
    
    # declare needed overloaded methods here
    def authorize(auth = {})
      @authentication ||= TaskMapper::Authenticator.new(auth)
      auth = @authentication
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
      else 
        TaskMapper::Provider::Github.login = login
        TaskMapper::Provider::Github.user_token = nil
        TaskMapper::Provider::Github.api = Octokit::Client.new(:login => login)
      end
    end

    def valid?
      begin
        TaskMapper::Provider::Github.valid_user = TaskMapper::Provider::Github.api.user.total_private_repos >= 0
      rescue
        false
      end
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


