require 'sequel'
require 'securerandom'

class DbRepo
  def initialize(url)
    @db = Sequel.connect(url)
    @todos = @db[:todos]
  end

  def nuke
    @db.drop_table? :todos
  end

  def prep
    @db.create_table? :todos do
      String :uid, :primary_key => true
      String :title
    end
  end

  def fetch_all
    @todos.all
  end

  def fetch(uid)
    @todos.first(:uid=>uid)
  end

  def insert(todo)
    todo[:uid] = SecureRandom.uuid
    @todos.insert todo
    todo
  end
end
