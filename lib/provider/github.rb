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

    def provider
      TaskMapper::Provider::Github
    end

    def new_github_client(auth)
      Octokit::Client.new auth
    end

    # declare needed overloaded methods here
    def authorize(auth = {})
      @authentication ||= TaskMapper::Authenticator.new(auth)
      auth[:login] = auth.fetch(:login) || auth.fetch(:username)
      raise TaskMapper::Exception.new('Please provide at least a username') if auth[:login].blank?
      provider.login = auth[:login]
      provider.user_token = auth[:password] || auth[:token]
      provider.api = new_github_client auth
    end

    def valid?
      provider.api.authenticated? || provider.api.oauthed?
    end

  end
end


