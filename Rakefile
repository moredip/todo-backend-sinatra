require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

desc "run the app"
task :server do
  ENV['DATABASE_URL'] ||= 'sqlite://todo.db'
  sh "rackup"
end

desc "reset the DB to a pristine state"
task :nuke_db do
  ENV['DATABASE_URL'] ||= 'sqlite://todo.db'
  require_relative 'lib/todo/db_repo'
  db_repo = DbRepo.from_database_url_env_var
  db_repo.nuke!
  db_repo.prep!
end

task :default => :spec
