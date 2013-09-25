module TaskMapper::Provider
  module Github
    class Project < TaskMapper::Provider::Base::Project
      def initialize(*object)
        object = object.first if object.is_a?(Array)
        super object
      end

      def id
        self.owner.login + "/" + self.name
      end

      # copy from this.copy(that) copies that into this
      def copy(project)
        project.tickets.each do |ticket|
          copy_ticket = self.ticket!(
            :title => ticket.title,
            :description => ticket.description
          )

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
          project_id = "#{login}/#{id}" unless id.include?("/")
          repo = api.repository(project_id).attrs
          self.new repo
        end

        def find_all
          repos = user_repos
          repos += org_repos if api.user_authenticated?
          repos
        end

        private
        def user_repos
          repos = api.repositories(login)
          repos.collect do |repo|
            self.new repo.attrs
          end
        end

        def org_repos
          repos = []
          api.organizations(login).each do |organization|
            org_login = organization.login
            repos += api.organization_repositories(org_login).collect do |repo|
              self.new repo.attrs
            end
          end
          repos.flatten
        end

        def api
          TaskMapper::Provider::Github.api
        end

        def login
          TaskMapper::Provider::Github.login
        end
      end

      def ticket(*options)
        if options.empty?
          Ticket
        else
          Ticket.find_by_id(self.id, options.first)
        end
      end

      def ticket!(*options)
        TaskMapper::Provider::Github::Ticket.open(self.id, options.first)
      end

      private
      def api
        self.class.api
      end

      def login
        self.class.login
      end
    end
  end
end
