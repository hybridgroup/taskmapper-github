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
          object = options.first
          @system_data = {:client => object}
          object[:author] = object['user']
          object[:project_id] = options[1]
          object[:ticket_id] = options[2]
          super object
        end
      end

      def created_at
        @created_at ||= begin
          Time.parse(self[:created_at])
          rescue
          self[:created_at]
          end
      end

       def created_at
        @updated_at ||= begin
          Time.parse(self[:updated_at])
          rescue
          self[:updated_at]
          end
      end
      
      # declare needed overloaded methods here
      def self.find_by_id(project_id, ticket_id, id)
	      warn "This method is not supported by Github's API"
      end
      
      def self.find_by_attributes(project_id, ticket_id, attributes = {})
      	warn "Github API only gets all comments"
      	self::API.find_all(Project.find(:first, [project_id]), ticket_id).collect {|comment| self.new comment, project_id, ticket_id}
      end
      
      def self.search(project_id, ticket_id, options = {}, limit = 1000)
	      warn "This method is not supported by Github's API"
      end
      
      def self.create(project_id, ticket_id, comment)
	      self.new self::API.create(Project.find(:first, [project_id]), ticket_id, comment)
      end
      
    end
  end
end
