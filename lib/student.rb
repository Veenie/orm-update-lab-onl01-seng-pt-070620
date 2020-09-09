require_relative "../config/environment.rb"

class Student

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]
  
attr_accessor :name, :grade
attr_reader :id
 
  def initialize(id=nil, name, grade)
    @id = id
    @name = name
    @grade = grade
  end
 
  def self.create_table
    sql =  <<-SQL
      CREATE TABLE IF NOT EXISTS students (
        id INTEGER PRIMARY KEY,
        name TEXT,
        grade TEXT
        )
        SQL
    DB[:conn].execute(sql)
  end
  
  def save
  if self.id
    self.update
  else
    sql = <<-SQL
      INSERT INTO songs (name, album)
      VALUES (?, ?)
    SQL
    DB[:conn].execute(sql, self.name, self.album)
    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM songs")[0][0]
  end
end
 

 
  def self.create(name:, grade:)
    song = Song.new(name, grade)
    song.save
    song
  end
 
  def self.find_by_name(name)
    sql = "SELECT * FROM students WHERE name = ?"
    result = DB[:conn].execute(sql, name)[0]
    Song.new(result[0], result[1], result[2])
  end
  
   def update
    sql = "UPDATE students SET name = ?, grade = ? WHERE id = ?"
    DB[:conn].execute(sql, self.name, self.grade, self.id)
  end
  
   def self. drop_table
     sql =  <<-SQL 
    DROP TABLE students;

        SQL
    DB[:conn].execute(sql) 
  end


end
