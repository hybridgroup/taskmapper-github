module TicketMaster::Provider
  module Github
    # Project class for ticketmaster-github
    #
    #
    class Project < TicketMaster::Provider::Base::Project
      
      # declare needed overloaded methods here
      def initialize(*object) 
        if object.first
          object = object.first
          unless object.is_a? Hash
            @system_data = {:client => object} 
            hash = {:description => object.description,
                    :created_at => object.created_at,
                    :name => object.name,
                    :id => object.name,
                    :owner => object.owner}
          else 
            hash = object
          end 
          super hash
        end
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

      def self.find(*options)
        if options.first.empty?
          TicketMaster::Provider::Github.api.repositories.collect { |repository| self.new repository }
        end
      end

    end
  end
end
