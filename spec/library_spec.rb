require('spec_helper')

describe(Book) do

  describe("#save") do
    it('stores a book in the database') do
      book = Book.new({:book_title => "A book"})
      book.save()
      expect(Book.all[0].fetch("title")).to eq("A book")
    end
  end

  describe()
end
