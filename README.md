Cackle.me integration
=====================

Simple Rails plugin implements synchronization of Cackle.me comments.

Cackle.me is a real-time comment system with the ability to login 
via popular social networks such as Google+, Facebook, Twitter, 
LinkedIn, Vkontakte, Odnoklassniki, Mail.ru and many others.

Storing in local database make comments visible to search robots.

Installation
------------

Add to Gemfile 
```ruby
gem 'cackle' 
```

Generate and run migration
```
rails g cacke_migration
rake db:migrate
```
Create config file config/cackle.yml
See http://cackle.me/help/comment-sync to get your keys

```yml
site_id:         12345          # Site ID
site_api_key:    blah-blah-blah # Account API Key
account_api_key: blah-blah-blah # Site API Key
jquery_off:      true           # Disable including jQuery if you already have it loaded

recent:                         # configuretion for recent comments block
  mcSize:        10             # how many comments to display
  mcAvatarSize:  32             # size of avatar image in pixels
  mcTextSize:    150            # length of message block if more shorten with '...'
  mcTitleSize:   40             # title length
```

Helper methods
==============

Insert comments widget
```ruby
cackle_comments 
```
Recent comments widget
```ruby
cackle_recent_comments 
```

Rake tasks
==========
First time import. Warning clears all comments in base.
```
cackle:import
```

Syncronize changes. Should be called every 5 minutes by cron.
```
cackle:sync
```

License
-------
This project rocks and uses MIT-LICENSE.