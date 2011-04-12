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
          @system_data = {:client => object} 
          unless object.is_a? Hash
            hash = {:description => object.description,
                    :created_at => object.created_at,
                    :updated_at => object.created_at,
                    :name => object.name,
                    :id => object.name,
                    :owner => object.owner}
          else 
            hash = object
          end 
          super hash
        end
      end

      def created_at
        begin 
          Time.parse(self[:created_at]) 
        rescue
          self[:created_at]
        end
      end

      def updated_at
        begin
          Time.parse(self[:created_at]) 
        rescue
          self[:created_at]
        end
      end

      def id
        "#{self[:owner]}/#{self[:name]}"
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

      def self.find_by_attributes(attributes = {})
        search_by_attribute(find_all, attributes).collect { |project| self.new project }
      end

      def self.find_by_id(id)
        id = "#{TicketMaster::Provider::Github.login}/#{id}" unless id.include?("/")
        self.new TicketMaster::Provider::Github.api.repository(id)
      end

      def self.find_all(*options)
        repos = []
        user_repos = TicketMaster::Provider::Github.api.repositories(TicketMaster::Provider::Github.login).collect { |repository| 
          self.new repository }
        repos = repos + user_repos
        unless TicketMaster::Provider::Github.user_token.nil?
          org_repos = TicketMaster::Provider::Github.api.organization_repositories.collect { |repository| 
            self.new repository }
          repos = repos + org_repos
        end
        puts repos.inspect
        repos
      end

      def tickets(*options)
        TicketMaster::Provider::Github::Ticket.find(self.id, options)
      end

      def ticket(*options)
        unless options.empty?
          TicketMaster::Provider::Github::Ticket.find_by_id(self.id, options.first)
        else
          TicketMaster::Provider::Github::Ticket
        end
      end

      def ticket!(*options)
        TicketMaster::Provider::Github::Ticket.open(self.id, options.first)
      end
    end

  end
end
