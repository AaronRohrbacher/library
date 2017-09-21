require('spec_helper')

describe(Author) do

  describe("#author_name") do
    it("gives you back the author") do
      author = Author.new({:author_name => "Hemmingway", :id => nil})
      expect(author.author_name()).to eq("Hemmingway")
    end
  end

  describe("#save") do
    it('stores an author in the database') do
      author = Author.new({:author_name => "Hemmingway", :id => nil})
      author.save()
      expect(Author.all[0].fetch("name")).to eq("Hemmingway")
    end
  end

  describe("#update") do
    it('updates a name of an author in the database') do
      book = Book.new({:book_title => "A Book", :id => nil})
      book.save()
      id = Book.all[0].fetch("id")
      book.update(:update_title => "Another Book", :id => id)
      expect(Book.all[0].fetch("title")).to eq("Another Book")
    end
    it("lets you add an author to a book") do
      author = Author.new({:author_name => "Hemmingway", :id => nil})
      author.save()
      a_book = Book.new({:book_title => "A Book", :id => nil})
      a_book.save()
      another_book = Book.new({:book_title => "Another Book", :id => nil})
      another_book.save()
      author.update({:book_id => [a_book.id(), another_book.id()]})
      expect(author.books()).to(eq([a_book, another_book]))
    end
  end

  describe("#books") do
    it("returns all of the books to a particular author") do
      author = Author.new({:author_name => "Hemmingway", :id => nil})
      author.save()
      a_book = Book.new({:book_title => "A Book", :id => nil})
      a_book.save()
      another_book = Book.new({:book_title => "Another Book", :id => nil})
      another_book.save()
      author.update({:book_id => [a_book.id(), another_book.id()]})
      expect(author.books()).to(eq([a_book, another_book]))
    end
  end

  describe("#delete") do
    it('delete a selected author') do
      array = []
      author = Author.new({:author_name => "Hemmingway", :id => nil})
      author.save()
      id = Author.all[0].fetch("id")
      author.delete(:id => id)
      Author.all.each do |author|
        array.push(author[0].fetch("name"))
      end
      expect(array).to eq([])
    end
  end

  describe("#search") do
    it('search for an author by it\'\s author') do
      author = Author.new({:author_name => "Hemmigway", :id => nil})
      author.save()
      expect(author.search("Hem")[0].fetch("name")).to eq("Hemmigway")
    end
  end

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
