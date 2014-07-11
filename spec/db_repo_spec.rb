require_relative '../lib/todo/db_repo'

def test_repo
  DbRepo.new('sqlite://todo-test.db') 
end

describe DbRepo do
  subject(:repo) {test_repo}

  before :all do
    test_repo.nuke
    test_repo.prep
  end

  describe 'fetch_all' do
    it 'returns an empty set of todos' do
      expect(repo.fetch_all).to eq([])
    end
  end

  describe 'insert' do
    it 'inserts' do
      repo.insert( title: "a todo" )
      expect(repo.fetch_all.size).to be(1)
    end

    it 'returns what it inserted, plus a uid' do
      todo = repo.insert( title: "a todo" )
      expect(todo).to include( title: "a todo" )
      expect(todo).to include( :uid )
    end

    it 'can look up an todo after inserting it' do
      created_todo = repo.insert( title: "a todo" )
      refetched_todo = repo.fetch( created_todo[:uid] )
      expect(refetched_todo).not_to be_nil
      expect(refetched_todo).to include( title: "a todo" )
    end
  end
end
