module TicketMaster::Provider
  module Github
    # Ticket class for ticketmaster-github
    
    class Ticket < TicketMaster::Provider::Base::Ticket
      
      @@allowed_states = %w{open close}
      attr_accessor :prefix_options
      API = Octopi::Issue
      # declare needed overloaded methods here
      
      def initialize(object)
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
      	          :created_at => object.created_at
      	    }
      	else
      	  hash = object
      	end

      	super hash
      end
      
      def self.find_by_id(project_id, ticket_id)
	      self.new self::API.find(build_attributes(project_id, {:number => ticket_id}))
      end
      
      def self.find_by_attributes(project_id, attributes = {})
      	attributes ||= {}
      	attributes[:state] ||= 'open'
      	self::API.find_all(build_attributes(project_id, attributes)).collect{|issue| self.new issue}
      end
      
      def self.build_attributes(repo, options)
      	hash = {:repo => repo, :user => Project.find(:first, [repo]).username}
      	hash.merge!(options)
      end
      
      def self.open(project_id, *options)
	      self::API.open(build_attributes(project_id, options.first))
      end
      
      def close
	      Ticket.new API.find(Ticket.build_attributes(repository, {:number => number})).close!
      end
      
      def reopen
	      Ticket.new API.find(Ticket.build_attributes(repository, {:number => number})).reopen!
      end
      
      def save
      	t = API.find(Ticket.build_attributes(repository, {:number => number}))
      	t.title = title
      	t.body = body
      	Ticket.new t.save
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
