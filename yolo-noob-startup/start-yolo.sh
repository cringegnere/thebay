#!/bin/bash
japphome () {
  cd /app
}
japphome
bundle check || bundle install
service postgresql start
service redis-server start
bundle exec rails db:migrate
bundle exec sidekiq -c 1 -d -L log/sidekiq.log
bundle exec rails server --port 3000 --binding 0.0.0.0
