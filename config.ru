$LOAD_PATH.unshift File.expand_path( "../lib", __FILE__ )

require 'todo/app'
require 'todo/repo'
require 'todo/db_repo'

def app
  db_url = ENV['DATABASE_URL'] || 'sqlite://todo.db'
  repo = TodoRepo.new
  db_repo = DbRepo.new(db_url)
  db_repo.prep!
  TodoApp.new( db_repo )
end

run app
