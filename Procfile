release: bundle exec rake heroku:release
web: bundle exec puma -C config/puma.rb
worker: bundle exec rake jobs:work
whacamole: bundle exec whacamole -c ./config/whacamole.rb

# comment: consider bin/rails server -p $PORT -e $RAILS_ENV for web (old heroku default)
