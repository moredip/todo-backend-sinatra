require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

desc "run the app"
task :server do
  sh "rackup"
end

task :default => :spec
