# class Author
#
# attr_reader(:author_name, :update_author, :id)
#   def initialize(attributes)
# 
#   end
#
#   def self.all
#     DB.exec("SELECT * FROM books")
#   end
#
#   def save
#     DB.exec("INSERT INTO books (title, author_id) VALUES ('#{@book_title}', #{@author_id});")
#   end
#
#   def update(attributes)
#     @update_title = attributes.fetch(:update_title)
#     @id = attributes.fetch(:id).to_i
#     DB.exec("UPDATE books SET title = '#{@update_title}' WHERE id = #{@id}")
#   end
#
#   def delete(attributes)
#     @id = attributes.fetch(:id).to_i
#     DB.exec("DELETE FROM books WHERE id = #{@id}")
#   end
#
#   def search(query)
#     DB.exec("SELECT * FROM books WHERE title LIKE '%#{query}%';")
#   end
# end
