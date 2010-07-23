module TicketMaster::Provider
  module Github
    # Ticket class for ticketmaster-github
    #
    
    class Ticket < TicketMaster::Provider::Base::Ticket
      
      @@allowed_states = %w{open close}
      attr_accessor :prefix_options
      API = Octopi::Issue
      # declare needed overloaded methods here
      
      def id
        @system_data[:client].number
      end
      
      # This is to get the status, mapped to state
      def status
        state
      end
      
      # This is to set the status, mapped to state
      def status=(stat)
        stat = state unless @@allowed_states.include?(stat)
        state = stat
      end
      
      def project_id
        prefix_options[:project_id]
      end
      
      def self.find(project_id, *options)
	first, attributes = options
	
	if first.class == Hash
	  API.find(first)
	else
	  super(project_id, first, attributes)
	end
      end
      
      def self.find_by_id(project_id, ticket_id)
	puts "Find by id"
      end
      
      def self.find_by_attributes(project_id, attributes = {})
	puts "Find by attr"
      end
      
      def self.search(project_id, options = {}, limit = 1000)
	puts "Search"
      end
    end
  end
end
