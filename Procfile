redis:   redis-server
db: postgres -D /usr/local/var/postgres
web: bundle exec rails s --port 3000
worker: bundle exec sidekiq -c 5 -v
