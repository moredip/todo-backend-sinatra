require_relative '../lib/todo/db_repo'

def test_repo
  DbRepo.new('sqlite://todo-test.db') 
end

describe DbRepo do
  subject(:repo) {test_repo}

  before :all do
    test_repo.nuke!
    test_repo.prep!
  end

  before :each do
    test_repo.delete_all
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

    it 'automagically adds a completed:false field' do
      created_todo = repo.insert( title: "blah" )
      refetched_todo = repo.fetch( created_todo[:uid] )
      expect(refetched_todo).to include( completed: false )
    end

    it 'copes with nonsense being passed in' do
      repo.insert( title: "blah", nonsense: "just go ahead and ignore me" )
    end
  end

  describe 'fetch_all' do
    it 'fetches details about each todo' do
      repo.insert( title: "wash the dog" )
      repo.insert( title: "feed the cat" )
      todos = repo.fetch_all

      todo_titles = todos.map{ |t| t[:title] }
      expect(todo_titles).to contain_exactly("wash the dog","feed the cat")
    end
  end

  describe 'update' do
    it 'can update a todo title' do
      todo = repo.insert( title: "wash the dog" )
      expect(repo.fetch( todo[:uid] )).to include( title: "wash the dog" )
      repo.update( todo[:uid], title: "wash the cat" )
      expect(repo.fetch( todo[:uid] )).to include( title: "wash the cat" )
    end
  end

  describe 'delete' do
    it 'deletes' do
      todo = repo.insert( title: "blah" )
      repo.delete( todo[:uid] )
      refetched_todo = repo.fetch( todo[:uid] )
      expect( refetched_todo ).to be_nil
    end
  end
end
