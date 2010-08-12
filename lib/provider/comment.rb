module TicketMaster::Provider
  module Github
    # The comment class for ticketmaster-github
    #
    # Do any mapping between Ticketmaster and your system's comment model here
    # versions of the ticket.
    #
    class Comment < TicketMaster::Provider::Base::Comment
      attr_accessor :prefix_options
      API = GithubComment
      
      def initialize(*options)
        if options.first.is_a? Hash
          super options.first
        end
      end
      
      # declare needed overloaded methods here
      def self.find_by_id(project_id, ticket_id, id)
	      warn "This method is not supported by Github's API"
      end
      
      def self.find_by_attributes(project_id, ticket_id, attributes = {})
      	warn "Github API only gets all comments"
      	self::API.find_all(Project.find(project_id), ticket_id).collect {|comment| self.new comment}
      end
      
      def self.search(project_id, ticket_id, options = {}, limit = 1000)
	      warn "This method is not supported by Github's API"
      end
      
      def self.create(project_id, ticket_id, comment)
	      self.new self::API.create(Project.find(project_id), ticket_id, comment)
      end
      
    end
  end
end
