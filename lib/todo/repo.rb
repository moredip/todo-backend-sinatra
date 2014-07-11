require 'securerandom'

class TodoRepo
  def initialize
    @store = {}
  end

  def add_todo(todo)
    todo = todo.clone
    uid = SecureRandom.uuid
    todo["uid"] = uid
    todo["completed"] = false
    @store[uid] = todo
    todo
  end

  def [](uid)
    @store[uid]
  end

  def all_todos
    @store.values
  end

  def clear!
    @store = {}
  end

  def delete(uid)
    @store.delete(uid)
  end
end
