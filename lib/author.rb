class Author

attr_reader(:author_name, :update_author)
attr_accessor(:id)
  def initialize(attributes)
    @author_name = attributes.fetch(:author_name)
    @id = attributes.fetch(:id)
  end

  def self.all
    DB.exec("SELECT * FROM authors")
  end

  def save
    item  = DB.exec("INSERT INTO authors (name) VALUES ('#{@author_name}') RETURNING id;")
    @id = item[0].fetch("id").to_i

  end

  def update(attributes)
    @author_name = attributes.fetch(:update_author, @author_name)
    DB.exec("UPDATE authors SET name = '#{@author_name}' WHERE id = #{self.id};")

    attributes.fetch(:book_id, []).each() do |book_id|
      DB.exec("INSERT INTO authors_books (book_id, author_id) VALUES (#{book_id}, #{self.id});")
    end
  end

  def ==(another_author)
    self.author_name().==(another_author.author_name()).&(self.id().==(another_author.id()))
  end

  def books
    author_books = []
    results = DB.exec("SELECT book_id FROM authors_books WHERE author_id = #{self.id};")
    results.each() do |result|
      book_id = result.fetch("book_id").to_i()
      book = DB.exec("SELECT * FROM books WHERE id = #{book_id};")
      book_title = book.first().fetch("title")
      author_books.push(Book.new({:book_title => book_title, :id => book_id}))
    end
    author_books
  end

  def delete(attributes)
    @id = attributes.fetch(:id).to_i
    DB.exec("DELETE FROM authors WHERE id = #{@id}")
  end

  def search(query)
    DB.exec("SELECT * FROM authors WHERE name LIKE '%#{query}%';")
  end
end
