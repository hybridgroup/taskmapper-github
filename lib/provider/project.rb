module TaskMapper::Provider
  module Github
    # Project class for taskmapper-github
    #
    #
    class Project < TaskMapper::Provider::Base::Project

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
        "#{self.owner.login}/#{self[:name]}"
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

      class << self
        def find_by_attributes(attributes = {})
          search_by_attribute(self.find_all, attributes)
        end

        def find_by_id(id)
          id = "#{TaskMapper::Provider::Github.login}/#{id}" unless id.include?("/")
          self.new TaskMapper::Provider::Github.api.repository(id) 
        end

        def find_all
          repos = [] + user_repos
          repos = repos + org_repos  if TaskMapper::Provider::Github.valid_user
          repos
        end

        private
        def user_repos
          TaskMapper::Provider::Github.api.repositories(TaskMapper::Provider::Github.login).collect do |repository| 
            self.new repository
          end
        end

        def org_repos
          org_repos = []
          user_orgs.each do |organization| 
            org_repos += TaskMapper::Provider::Github.api.organization_repositories(organization.login).collect do |repository| 
              self.new(repository)
            end
          end
          org_repos.flatten
        end

        def user_orgs
          TaskMapper::Provider::Github.api.organizations(TaskMapper::Provider::Github.login)
        end
      end

      def ticket(*options)
        unless options.empty?
          TaskMapper::Provider::Github::Ticket.find_by_id(self.id, options.first)
        else
          TaskMapper::Provider::Github::Ticket
        end
      end

      def ticket!(*options)
        TaskMapper::Provider::Github::Ticket.open(self.id, options.first)
      end
    end

  end
end
