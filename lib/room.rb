class Room
  attr_accessor :id, :title, :date_created, :price, :url

  def self.create_from_hash(hash) #Instantiating and saving
    new_from_hash(hash).save
  end

  def self.new_from_hash(hash) #Just Instantiating
    room = self.new
    room.title = hash[:title]
    room.date_created = hash[:date_created]
    room.price = hash[:price]
    room.url = hash[:url]

    room #dangling return value
  end

  def save
    insert
  end

  def self.new_from_db(row)
    self.new.tap do |room| #tap lets you revieve the object(for a moment) as a block level variable
      room.id = row[0]
      room.title = row[1]
      room.date_created = row[2]
      room.price = row[3]
      room.url = row[4]
    end
  end

  def self.all
    sql = <<-SQL
      SELECT * FROM rooms;
    SQL

    rows = DB[:connection].execute(sql)
    rows.collect do |row|
      self.new_from_db(row)
    end
  end

  def self.by_price(order = "ASC")
    case order
    when "ASC"
      self.all.sort_by{|r| r.price}
    when "DESC"
      self.all.sort_by{|r| r.price}.reverse
    end
  end

  def insert
    #need a database
    puts "You are saving #{self}"
    sql = <<-SQL
      INSERT INTO rooms(title, date_created, price, url) VALUES (?, ?, ?, ?)
    SQL

    DB[:connection].execute(sql, self.title, self.date_created, self.price, self.url)
  end

  def self.create_table
    sql = <<-SQL
      CREATE TABLE IF NOT EXISTS rooms (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        date_created TEXT,
        price TEXT,
        url TEXT
      )
    SQL

    DB[:connection].execute(sql)
  end
end
