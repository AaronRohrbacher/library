require('spec_helper')

describe(Book) do

  describe("#book_title") do
    it("gives you back the book title") do
      book = Book.new({:book_title => "Title of a Book", :id => nil})
      expect(book.book_title()).to eq("Title of a Book")
    end
  end

  describe("#save") do
    it('stores a book in the database') do
      book = Book.new({:book_title => "A book", :id => nil})
      book.save()
      expect(Book.all[0].fetch("title")).to eq("A book")
    end
  end

  describe("#update") do
    it('updates a name of a book in the database') do
      book = Book.new({:book_title => "A book", :id => nil})
      book.save()
      id = Book.all[0].fetch("id")
      book.update(:update_title => "Some other book", :id => id)
      expect(Book.all[0].fetch("title")).to eq("Some other book")
    end
    it("lets you add an author to a book") do
      book = Book.new({:book_title => "A Hemmingway Book", :id => nil})
      book.save()
      hemmingway = Author.new({:author_name => "Hemmingway", :id => nil})
      hemmingway.save()
      rohrbacher = Author.new({:author_name => "Rohrbacher", :id => nil})
      rohrbacher.save()
      book.update({:author_id => [hemmingway.id(), rohrbacher.id()]})
      expect(book.authors()).to(eq([hemmingway, rohrbacher]))
    end
  end

  describe("#authors") do
    it("returns all of the authors to a particular book") do
      book = Book.new({:book_title => "A Hemmingway Book", :id => nil})
      book.save()
      hemmingway = Author.new({:author_name => "Hemmigway", :id => nil})
      hemmingway.save()
      rohrbacher = Author.new({:author_name => "Rohrbacher", :id => nil})
      rohrbacher.save()
      book.update({:author_id => [hemmingway.id(), rohrbacher.id()]})
      expect(book.authors()).to(eq([hemmingway, rohrbacher]))
    end
  end

  describe("#delete") do
    it('delete a selected book') do
      array = []
      book = Book.new({:book_title => "A book", :id => nil})
      book.save()
      id = Book.all[0].fetch("id")
      book.delete(:id => id)
      Book.all.each do |book|
        array.push(book[0].fetch("name"))
      end
      expect(array).to eq([])
    end
  end

  describe("#search") do
    it('search for a book by it\'\s title') do
      book = Book.new({:book_title => "A book", :id => nil})
      book.save()
      expect(book.search("book")[0].fetch("title")).to eq("A book")
    end
  end

  # describe("#catalog") do
  #   it('Adds a book and its authors to catalog') do
  #     book = Book.new({:book_title => "title1"})
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
