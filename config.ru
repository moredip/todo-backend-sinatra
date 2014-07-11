$LOAD_PATH.unshift File.expand_path( "../lib", __FILE__ )

require 'todo/app'
require 'todo/repo'

def app
  db_url = ENV['DATABASE_URL'] || 'sqlite://todo.db'
  repo = TodoRepo.new
  TodoApp.new( repo )
end

run app
