class Author

attr_reader(:author_name, :update_author, :id)
  def initialize(attributes)
    @author_name = attributes.fetch(:author_name)
  end

  def self.all
    DB.exec("SELECT * FROM authors")
  end

  def save
    DB.exec("INSERT INTO authors (name) VALUES ('#{@author_name}');")
  end

  # def update(attributes)
  #   @update_title = attributes.fetch(:update_title)
  #   @id = attributes.fetch(:id).to_i
  #   DB.exec("UPDATE authors SET title = '#{@update_title}' WHERE id = #{@id}")
  # end
  #
  # def delete(attributes)
  #   @id = attributes.fetch(:id).to_i
  #   DB.exec("DELETE FROM authors WHERE id = #{@id}")
  # end
  #
  # def search(query)
  #   DB.exec("SELECT * FROM authors WHERE title LIKE '%#{query}%';")
  # end
end
