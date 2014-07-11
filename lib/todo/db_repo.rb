require 'sequel'
require 'securerandom'

class DbRepo
  def initialize(url)
    @db = Sequel.connect(url)
    @todos = @db[:todos]
  end

  def nuke!
    @db.drop_table? :todos
  end

  def prep!
    @db.create_table? :todos do
      String :uid, :primary_key => true
      String :title
      Boolean :completed
    end
  end

  def delete_all
    @todos.delete
  end
  alias_method :clear!, :delete_all

  def delete(uid)
    @todos.where(:uid=>uid).delete
  end

  def fetch_all
    @todos.all
  end
  alias_method :all_todos, :fetch_all

  def fetch(uid)
    @todos.first(:uid=>uid)
  end
  alias_method :[], :fetch

  def insert(todo)
    todo[:uid] = SecureRandom.uuid
    todo[:completed] = false
    @todos.insert todo
    todo
  end
  alias_method :add_todo, :insert

  def update(uid,todo_attrs)
    @todos.where(:uid=>uid).update(todo_attrs)
  end
  alias_method :[]=, :update

end
