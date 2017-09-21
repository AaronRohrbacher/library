require("sinatra")
require("sinatra/reloader")
also_reload("lib/**/*.rb")
require("./lib/author")
require("./lib/book")
require("pg")

DB = PG.connect({:dbname => "library_manager"})

get('/') do
  @books = Book.all()
  @authors = Author.all()
  erb(:index)
end

get('/authors/:id') do
  @author_name = Author.find()
end
