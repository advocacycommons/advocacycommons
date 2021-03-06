source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.5'#, '>= 5.0.0.1'
# Use Puma as the app server
gem 'puma', '~> 3.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

gem 'rake', '12.1.0'
gem 'cancancan'
gem 'devise'
gem 'omniauth'
gem 'omniauth-facebook'
gem 'omniauth-twitter'
gem 'omniauth-google-oauth2'
gem 'bootstrap', '~> 4.0.0.alpha5'
source 'https://rails-assets.org' do
  gem 'rails-assets-tether', '>= 1.3.3'
end
gem 'roar-jsonapi'

# postgresql database adatper
gem 'pg'

#pretty layout for console
gem 'hirb'

gem 'wicked_pdf'
gem 'wkhtmltopdf-heroku'
gem 'wkhtmltopdf-binary-edge', '~> 0.12.4.0'

# NOTE(aguestuser|27 Apr 2018)
# these ide debugger gems break ruby 2.5.1 installs
# commenting them until we can figure out how to successfully
# upgrade to ruby 2.5.1, rails 5.2.0
#gem 'ruby-debug-ide'
#gem 'rdebug-ide'
#gem 'debase'
# This is an optional gem. When included, GraphQL will use a parser written in C
# instead of the Ruby parser shipped with graphql-ruby.
#gem 'graphql-libgraphqlparser', '~> 0.2'

# Asset compilation and NPM modules
gem 'browserify-rails'

gem 'geokit-rails'
gem 'active_model_serializers'

# Use jquery as the JavaScript library
gem 'jquery-rails'
gem 'jquery-ui-rails', '~> 5.0.4'

#disabling because we're using react
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
#gem 'turbolinks', '~> 5'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
gem 'roar'
gem 'react_on_rails', '~> 6.8.0'

# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development


#gem "administrate", "~> 0.3.0"
gem 'activeadmin', '~> 1.0.0.pre4'
gem 'inherited_resources', github: 'activeadmin/inherited_resources'

gem 'kaminari'
gem 'doorkeeper', ">= 4.3.1" # vuln pin
gem 'httparty'
gem 'acts-as-taggable-on', '~> 4.0'

gem 'paper_trail'
gem 'derailed'
gem 'memory_profiler'
gem 'resque'
gem 'hiredis'
gem 'redis'
gem 'resque-scheduler'
gem 'rb-fsevent', '~> 0.10.2'
gem 'arel-helpers'
gem 'koala'
gem 'cocoon'
gem 'nokogiri'

gem 'google-api-client', '~> 0.10.3'
gem 'googleauth'

# memory profiling
gem 'scout_apm'

# crypto
gem 'rbnacl-libsodium'

# factories
# - included here so we can use them on staging
# - eg: rake qa:gen_big_subgroup
gem 'factory_bot_rails'
gem 'faker'

# Excel / Spreadsheet Export
gem 'axlsx_rails'
gem 'zip-zip'

# heroku memory monitor / worker restarter
gem 'whacamole'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'dotenv-rails'
  gem 'byebug', platform: :mri
  gem 'awesome_print'
  gem 'pry' # for debugging, robe console, etc...
  gem 'dotenv'
  gem 'pry-remote'
end

group :development do
  gem 'foreman'

  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console'
  #gem 'listen'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  #############
  # profiling #
  #############
  # lightweight profiling tool: https://github.com/MiniProfiler/rack-mini-profiler
  # miniprofiler is GREAT, but it appears to cause our action network sync
  # (and thus seed:db) to fail. commenting out for now, investigating later
  gem 'rack-mini-profiler'
  # For memory profiling
  gem 'memory_profiler'
  # For call-stack profiling flamegraphs
  gem 'flamegraph'
  gem 'stackprof'

  # until 4.7.3, we need develop branch b/c: https://github.com/ctran/annotate_models/pull/514
  gem 'annotate', git: 'https://github.com/ctran/annotate_models.git', branch: "develop"
  gem 'guard'
  gem 'guard-minitest'
end

group :test do
  gem 'rails-controller-testing'
  gem 'webmock'
  gem 'minitest', '~> 5.10.3'
  gem 'minitest-spec-rails'
  gem 'minitest-matchers'
  gem 'minitest-focus'
  gem 'valid_attribute'
  gem 'minitest-rails-capybara'
  gem 'rspec-mocks'
  gem 'selenium-webdriver'
  gem 'launchy'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]


ruby ">=2.3.3"

gem 'mini_racer', platforms: :ruby

source 'https://rails-assets.org' do
  gem 'rails-assets-tether', '>= 1.3.3'
end
