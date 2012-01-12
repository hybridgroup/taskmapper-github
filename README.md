# ticketmaster-github

This is a provider for [ticketmaster](http://ticketrb.com). It provides
interoperability with [Github](http://www.github.com/) and its issue tracking
system through the ticketmaster gem.

# Usage and Examples

First we have to instantiate a new ticketmaster instance:

```ruby
github = TicketMaster.new(:github, {:login => "coder", :token => "m4st3r!"})
```

If you do not pass in the token and the username, it will only access public
information for the account.

## Finding Projects(Repositories)

You can find your own projects by doing:

```ruby
projects = github.projects # Will return all your repositories
projects = github.projects(['your_repo1', 'your_repo2'])
project = github.project('your_repo')
```

Also you can access other users repos:
	
```ruby
project = github.project.find(:first, {:user => 'other_user', :repo => 'his_repo'})
```

Or even make a search with an array:

```ruby
projects = github.project.find(:all, ['ruby','git'])
```
	
## Finding Tickets (Issues)

```ruby
tickets = project.tickets # All open issues
tickets = project.tickets(:all, {:state => 'closed'}) # All closed tickets
ticket = project.ticket(<issue_number>)
```

## Open Tickets
    
```ruby
ticket = project.ticket!({:title => "New ticket", :body => "Body for the very new ticket"})
```

## Close a ticket
	
```ruby
ticket = ticket.close
```
	
## Reopen a ticket

```ruby
ticket = ticket.reopen
```
	
## Update a ticket
	
```ruby
ticket.title = "New title"
ticket.body =  "New body"
ticket.save
```

## Finding Comments
```ruby
comments = ticket.comments
```

## Create Comment

```ruby
comment = ticket.comment!("your comment goes here")
```

## Requirements

* rubygems (obviously)
* ticketmaster gem (latest version preferred)
* jeweler gem (only if you want to repackage and develop)
* Octopi gem provides interface to Github

The ticketmaster gem should automatically be installed during the installation
of this gem if it is not already installed.

## Other Notes

Since this and the ticketmaster gem is still primarily a work-in-progress,
minor changes may be incompatible with previous versions. Please be careful
about using and updating this gem in production.

If you see or find any issues, feel free to open up an issue report.


## Note on Patches/Pull Requests
 
* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so we don't break it in a
  future version unintentionally.
* Commit, do not mess with rakefile, version, or history.
  (if you want to have your own version, that is fine but bump version in a commit by itself so we can ignore when I pull)
* Send us a pull request. Bonus points for topic branches.

## Copyright

Copyright (c) 2010-2011 The Hybrid Group. See LICENSE for details.
