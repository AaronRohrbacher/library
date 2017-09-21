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

  def ==(another_author)
    self.author_name().==(another_author.author_name()).&(self.id().==(another_author.id()))
  end


  def update(attributes)
    @update_author = attributes.fetch(:update_author, :id)
    @id = attributes.fetch(:id).to_i
    DB.exec("UPDATE authors SET name = '#{@update_author}' WHERE id = #{@id}")
  end

  def delete(attributes)
    @id = attributes.fetch(:id).to_i
    DB.exec("DELETE FROM authors WHERE id = #{@id}")
  end

  def search(query)
    DB.exec("SELECT * FROM authors WHERE name LIKE '%#{query}%';")
  end
end
