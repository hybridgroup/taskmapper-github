module TicketMaster::Provider
  module Github
    # Ticket class for ticketmaster-github
    
    class Ticket < TicketMaster::Provider::Base::Ticket
      
      @@allowed_states = %w{open close}
      attr_accessor :prefix_options
      API = Octopi::Issue
      # declare needed overloaded methods here
      
      def initialize(*object)
        if object.first
          object = object.first
          @system_data = {:client => object}
        	unless object.is_a? Hash
        	  hash = {:repository => object.repository.name,
        	          :user => object.user,
        	          :updated_at => object.updated_at,
        	          :votes => object.votes,
        	          :number => object.number,
        	          :title => object.title,
        	          :body => object.body,
        	          :closed_at => object.closed_at,
        	          :labels => object.labels,
        	          :state => object.state,
        	          :created_at => object.created_at,
        	          :id => object.number,
        	          :project_id => object.repository.name,
        	          :description => object.body,
        	          :status => object.state,
        	          :resolution => (object.state == 'closed' ? 'closed' : nil),
        	          :requestor => object.user
        	    }
        	else
        	  hash = object
        	end

        	super hash
      	end
      end
      
      def self.find_by_id(project_id, ticket_id)
	      self.new self::API.find(build_attributes(project_id, {:number => ticket_id}))
      end
      
      def self.find_by_attributes(project_id, attributes = {})
      	attributes ||= {}
        issues = []
      	if attributes[:state].nil?
      	  attributes[:state] = 'open'
          issues += self::API.find_all(build_attributes(project_id, attributes))
          attributes[:state] = 'closed'
          begin
            issues += self::API.find_all(build_attributes(project_id, attributes))
          rescue APICache::TimeoutError
            warn "Unable to fetch closed issues due to timeout"
          end
        else
      	  issues = self::API.find_all(build_attributes(project_id, attributes))
      	end
      	issues.collect { |issue| self.new issue }
      end
      
      def self.build_attributes(repo, options)
      	hash = {:repo => repo, :user => TicketMaster::Provider::Github.login}
      	hash.merge!(options)
      end
      
      def self.open(project_id, *options)
        begin
	        self.new self::API.open(build_attributes(project_id, options.first))
        rescue
          self.find(project_id, :all).last
        end
      end
      
      def close
	      Ticket.new API.find(Ticket.build_attributes(repository, {:number => number})).close!
      end
      
      def reopen
	      Ticket.new API.find(Ticket.build_attributes(repository, {:number => number})).reopen!
      end
      
      def save
      	t = API.find(Ticket.build_attributes(repository, {:number => number}))
      	
      	return false if t.title == title and t.body == body
      	
      	t.title = title
      	t.body = body
      	t.save
      	
      	true
      end
      
      def comments
	      Comment.find(repository, number, :all)
      end
      
      def comment!(comment)
	      Comment.create(repository, number, comment)
      end
      
    end
  end
end
