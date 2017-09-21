class Book

attr_reader(:book_title, :update_title)
attr_accessor(:id)
  def initialize(attributes)
    @book_title = attributes.fetch(:book_title)
    @id = attributes.fetch(:id)
  end

  def self.all
    DB.exec("SELECT * FROM books")
  end

  def save
    item = DB.exec("INSERT INTO books (title) VALUES ('#{@book_title}') RETURNING id;")
    @id = item[0].fetch("id").to_i
  end

  def update(attributes)
    @book_title = attributes.fetch(:update_title, @book_title)
    DB.exec("UPDATE books SET title = '#{@book_title}' WHERE id = #{self.id};")

    attributes.fetch(:author_id, []).each() do |author_id|
      DB.exec("INSERT INTO authors_books (author_id, book_id) VALUES (#{author_id}, #{self.id});")
    end
  end

  def ==(another_book)
    self.book_title().==(another_book.book_title()).&(self.id().==(another_book.id()))
  end

  def authors
    book_authors = []
    results = DB.exec("SELECT author_id FROM authors_books WHERE book_id = #{self.id};")
    results.each() do |result|
      author_id = result.fetch("author_id").to_i()
      author = DB.exec("SELECT * FROM authors WHERE id = #{author_id};")
      author_name = author.first().fetch("name")
      book_authors.push(Author.new({:author_name => author_name, :id => author_id}))
    end
    book_authors
  end

  def delete(attributes)
    @id = attributes.fetch(:id).to_i
    DB.exec("DELETE FROM books WHERE id = #{@id}")
  end

  def search(query)
    DB.exec("SELECT * FROM books WHERE title LIKE '%#{query}%';")
  end
end
