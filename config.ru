$LOAD_PATH.unshift File.expand_path( "../lib", __FILE__ )

require 'todo/app'
require 'todo/repo'
require 'todo/db_repo'

def app
  db_repo = DbRepo.from_database_url_env_var
  db_repo.prep!
  TodoApp.new( db_repo )
end

run app
