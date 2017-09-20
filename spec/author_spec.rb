require('spec_helper')

describe(Author) do

  describe("#author_name") do
    it("gives you back the author") do
      author = Author.new({:author_name => "Hemmingway"})
      expect(author.author_name()).to eq("Hemmingway")
    end
  end

  describe("#save") do
    it('stores an author in the database') do
      author = Author.new({:author_name => "Hemmingway"})
      author.save()
      expect(Author.all[0].fetch("name")).to eq("Hemmingway")
    end
  end

  # describe("#update") do
  #   it('updates a name of a book in the database') do
  #     book = Author.new({:book_title => "A book"})
  #     book.save()
  #     id = Author.all[0].fetch("id")
  #     book.update(:update_title => "Some other book", :id => id)
  #     expect(Author.all[0].fetch("title")).to eq("Some other book")
  #   end
  # end
  #
  # describe("#delete") do
  #   it('delete a selected book') do
  #     array = []
  #     book = Author.new({:book_title => "A book"})
  #     book.save()
  #     id = Author.all[0].fetch("id")
  #     book.delete(:id => id)
  #     Author.all.each do |book|
  #       array.push(book[0].fetch("name"))
  #     end
  #     expect(array).to eq([])
  #   end
  # end
  #
  # describe("#search") do
  #   it('search for a book by it\'\s title') do
  #     book = Author.new({:book_title => "A book", :author_id => 1})
  #     book.save()
  #     expect(book.search("book")[0].fetch("title")).to eq("A book")
  #   end
  # end
  #
  # describe("#catalog") do
  #   it('Adds a book and its authors to catalog') do
  #     book = Author.new({:book_title => "title1"})
  #     book.save
  #     author = Author.new({:author_name => "Hemmigway"})
  #     author.save
  #
  #     catalog = Catalog.new({:book_id => author.book_id, :author_id => })
  #     catalog.save
  #
  #     author2 = Author.new({:author_name => "Dickenson"})
  #     author2.save
  #
  #
  #     catalog2 = Catalog.new({:book_id => author2.book_id, :author_id => })
  #     catalog2.save
  #
  #   end
  # end

end
