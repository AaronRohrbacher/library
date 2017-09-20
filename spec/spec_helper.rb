require('book')
require('pry')
require('rspec')
require('pg')

DB = PG.connect({:dbname => "library_manager_test"})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM books *;")
  end
end
