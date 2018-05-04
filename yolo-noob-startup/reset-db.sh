#!/bin/bash"
japphome () {
  cd /app
}
japphome
service postgresql start
service redis-server start
bundle exec rails db:drop
bundle exec rails db:create db:migrate db:seed
