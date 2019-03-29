class Room
  attr_accessor :title, :date_created, :price, :url

  def self.create_from_hash(hash) #Instantiating and saving
    new_from_hash(hash).save
  end

  def self.new_from_hash(hash) #Just Instantiating
    room = self.new
    room.title = hash[:title]
    room.date_created = hash[:date_created]
    room.price = hash[:price]
    room.url = hash[:url]
    binding.pry
    room
  end

  def save
    puts "You are saving #{self}"
  end
end
