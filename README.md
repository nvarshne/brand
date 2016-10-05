# Ruby Version
`2.3.1`

# System Dependencies (w/ installation on Mac)
`rbenv, ruby, rails, postgres, git, homebrew`

Set up ssh keys in your git:
```
$ open https://help.github.com/articles/generating-an-ssh-key/
```

install homebrew to install rbenv, then use rbenv to install/manage ruby:
```
$ ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
$ brew install rbenv ruby-build
$ echo 'if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi' >> ~/.bash_profile
$ source ~/.bash_profile

$ rbenv install 2.3.1
$ rbenv global 2.3.1
```

check the install:
```
$ ruby -v
```

Install rails:
```
$ gem install rails -v 4.2.6
```

reload your new rails gems into rbenv:
```
$ rbenv rehash
```

check rails install:
```
$ rails -v
```

Install PostgreSQL 9.6.0
```
$ open http://postgresapp.com/
```

Configure to Start Postgres at login (and launch it now)
```
$ ln -sfv /usr/local/opt/postgresql/*plist ~/Library/LaunchAgents
$ launchctl load ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist
```

# Configuration

Open the repo.

Install the needed gems:
```
$ bundle install
```

# Database Creation

Edit `config/database.yml` to be whatever username & password you want. Maybe choose `colab`

Create the database
```
$ rails db:create
```

If you need a fresh start, first run this:
```
$ rails db:drop
```

# Database Initialization
Migrate the database:
```
$ rails db:migrate
```

You can now run the app locally:
```
$ rails server
```

# Running Tests
Full test suite
```
$ rails test
```

Just models, just integration
```
$ rails test:models
$ rails test:integration
```

Just one specific test:
```
$ rails test test/integration/users_login_test.rb --name test_login_with_valid_information,_then_logout
```

# Services

#### TODO
job queues, caching, sharding...

# Deployment Instructions

Make sure all tests pass, then push to heroku:

Push to production:
```
$ git push heroku master
```
