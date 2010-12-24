module TicketMaster::Provider
  module Github
    # Project class for ticketmaster-github
    #
    #
    class Project < TicketMaster::Provider::Base::Project
      attr_accessor :prefix_options, :name, :user
      
      API = Octopi::Repository
      # declare needed overloaded methods here
      
      def initialize(*object)
        if object.first
          object = object.first
          @system_data = {:client => object}
          hash = {'description' => object.description,
  	        'url' => object.url,
            'forks' => object.forks,
            'name' => object.name,
            'homepage' => object.homepage,
            'watchers' => object.watchers,
            'private' => object.private,
            'fork' => object.fork,
            'open_issues' => object.open_issues,
            'pledgie' => object.pledgie,
            'size' => object.size,
            'actions' => object.actions,
            'score' => object.score,
            'language' => object.language,
            'followers' => object.followers,
            'type' => object.type,
            'username' => object.username,
            'id' => object.name,
            'pushed' => object.pushed,
            'created' => object.created}
            
  	      @name = object.name
  	      @user = object.username
  	      super hash
	      end
      end
      
      def self.search(options = {}, limit = 100)
	      raise "Please supply arguments for search" if options.blank?
      	if options.is_a? Hash
      	  r = self.new self::API.find(options)
      	  [] << r
      	else
      	  self::API.find_all(options)[0...limit].collect { |repo| self.new repo }
      	end
      end
      
      def self.find_by_id(id)
        warn "Github API only finds by name"
        self.new self::API.find({:user => TicketMaster::Provider::Github.login, :repo => id})
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
      
      def easy_finder(api, *options)
      	if api.is_a? Class
      	  #return api if options.length == 0 and symbol == :first
      	  api.find(*options)
      	end
      end

      def ticket(*options)
        TicketMaster::Provider::Github::Ticket.find(self.id, *options)
      end
      
      def tickets(*options)
      	TicketMaster::Provider::Github::Ticket.find(self.id, *options)
      end
    
      def ticket!(*options)
        TicketMaster::Provider::Github::Ticket.open(name, {:params => options.first})
      end
      
    end
  end
end
