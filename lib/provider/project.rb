module TicketMaster::Provider
  module Github
    # Project class for ticketmaster-github
    #
    #
    class Project < TicketMaster::Provider::Base::Project
      attr_accessor :prefix_options
      API = Octopi::Repository
      # declare needed overloaded methods here
      
      def self.find(*options)
	first, attributes = options
	if first.class == Hash
	  self::API.find(first)
	else
	  super(first, attributes)
	end
      end
      
      def self.search(options = {}, limit = 100)
	raise "Please supply arguments for search" if options.blank?
	self::API.find_all(options)[0...limit]
      end
      
      # copy from this.copy(that) copies that into this
      def copy(project)
        project.tickets.each do |ticket|
          copy_ticket = self.ticket!(:title => ticket.title, :description => ticket.description)
          ticket.comments.each do |comment|
            copy_ticket.comment!(:body => comment.body)
            sleep 1
          end
        end
      end

    end
  end
end


