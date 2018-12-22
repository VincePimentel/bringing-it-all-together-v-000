require 'pry'

class Dog
  attr_accessor :name, :breed
  attr_reader :id

  def initialize(name:, breed:, id: nil)
    @id = id
    @name = name
    @breed = breed
  end

  def self.create_table
    sql = <<-SQL
      CREATE TABLE IF NOT EXISTS dogs (
        id INTEGER PRIMARY KEY,
        name TEXT,
        breed TEXT
      );
    SQL

    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = "DROP TABLE dogs;"

    DB[:conn].execute(sql)
  end

  def self.new_from_db(row)
    dog = self.new(row[1], row[2], row[0])
    dog
  end

  def save
    if self.id
      self.update
    else
      sql = <<-SQL
        INSERT INTO dogs (name, breed)
        VALUES (?, ?);
      SQL

      DB[:conn].execute(sql, self.name, self.breed)

      @id = DB[:conn].execute("SELECT last_insert_rowid() FROM dogs;")[0][0]
    end
    
    self
  end

  def self.create(dog_hash)
    dog = self.new(dog_hash[:name], dog_hash[:breed])
    dog.save
    dog
  end

  def update
    sql = <<-SQL
      UPDATE dogs
      SET name = ?, breed = ?
      WHERE id = ?;
    SQL

    DB[:conn].execute(sql, self.name, self.breed, self.id)
  end
end
