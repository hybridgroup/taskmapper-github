module TaskMapper::Provider
  module Github
    class Project < TaskMapper::Provider::Base::Project
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
          search_by_attribute find_all, attributes
        end

        def find_by_id(id)
          project_id = "#{login}/#{id}" unless id.include?("/")
          repo = api.repository(project_id).attrs
          self.new repo
        end

        def find_all
          repos = []
          repos += org_repos if api.user_authenticated?
          repos += user_repos
        end

        private
        def user_repos
          api.repositories(login).collect { |repo| self.new repo.attrs }
        end

        def org_repos
          api.organizations(login).collect do |organization|
            org_login = organization.login
            api.organization_repositories(org_login).map do |repo|
              self.new repo.attrs
            end
          end.flatten
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
