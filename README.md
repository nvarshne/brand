# ad-market
# TODO

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

## newdev setup, mac:

### Install Necessary Tools
`homebrew, rbenv, ruby, rails, postgres`

Set up ssh keys in your git:
https://help.github.com/articles/generating-an-ssh-key/

install homebrew:
```
$ ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

install rbenv, use rbenv to install ruby:
```
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

Install PostgreSQL
```
$ brew install postgresql
```

Start Postgres at login (and launch it now)
```
$ ln -sfv /usr/local/opt/postgresql/*plist ~/Library/LaunchAgents
$ launchctl load ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist
```

### Start the App

Clone the repo, cd into it.

Install the needed gems:
```
$ bundle install --without production
```

Migrate the database:
```
$ rails db:migrate
```

Run the test suite to verify that everything is working correctly:
```
$ rails test
```

If the test suite passes, you'll be ready to run the app in a local server:
```
$ rails server
```




## Reference: app creation with pg connection
```
$ rails new myapp -d postgresql
```
then change `config/database.yml` to be your osx name. Or just whatever user/pass you want

```
$ rake db:create
$ rails server
```
