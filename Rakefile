require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

desc "run the app"
task :server do
  ENV['DATABASE_URL'] ||= 'sqlite://todo.db'
  sh "rackup"
end

task :default => :spec
