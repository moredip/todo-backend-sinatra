source 'https://www.rubygems.org'
ruby '2.0.0'

gem 'rake'
gem 'rspec-core' # needed outside of test so we can evaluate Rakefile

gem 'sinatra'
gem 'sequel'

group :production do
  gem 'thin'
	gem 'pg'
end

group :test do
  gem 'rspec'
  gem 'rack-test'
  gem 'rest_client'
  gem 'sqlite3'
end

group :development do
  gem 'pry-nav'
  gem 'sinatra-contrib'
end
