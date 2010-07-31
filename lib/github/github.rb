module TicketMaster::Provider
  module Github
    
    class GithubComment
      include HTTParty
      URI = 'http://github.com/api/v2/json'
      attr_accessor :gravatar_id, :created_at, :body, :updated_at, :id, :user
      
      base_uri "http://github.com/api/v2/json"
      
      def self.find_all(repo, number)
	response = HTTParty.get("#{URI}/issues/comments/#{repo.username}/#{repo.name}/#{number}", :query => auth_params).parsed_response['comments']
      end
      
      def self.create(repo, number, comment)
	response = HTTParty.post("#{URI.gsub('http','https')}/issues/comment/#{repo.username}/#{repo.name}/#{number}", :query => auth_params, :body => {:comment => comment}).parsed_response['comment']
      end
      
      def self.auth_params
	{:login => Octopi::Api.api.login, :token => Octopi::Api.api.token}
      end
    end
  end
end