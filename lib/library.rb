class Book

attr_reader(:book_title)
  def initialize(attributes)
    @book_title = attributes.fetch(:book_title)
  end

  def self.all
    DB.exec("SELECT * FROM books")
  end

  def save
    DB.exec("INSERT INTO books (title, author_id) VALUES ('#{@book_title}', 1);")
  end
end
