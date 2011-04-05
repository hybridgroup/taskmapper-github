module TicketMaster::Provider
  module Github
    # Ticket class for ticketmaster-github
    
    class Ticket < TicketMaster::Provider::Base::Ticket
      
      @@allowed_states = %w{open close}
      attr_accessor :prefix_options
      #API = Octopi::Issue
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
      
    end
  end
end
