class HashClass
  require_relative 'hash_item'
  attr_accessor :items
  
  def initialize(size)
    @items = Array.new(size)
  end

  def []=(key, value)
    hash_item = HashItem.new(key, value)
    hash_index = self.index(key, @items.length)

    if @items[hash_index] == nil
      @items[hash_index] = hash_item
    elsif @items[hash_index].key == key and @items[hash_index].value != value
      self.resize
    elsif @items[hash_index].key != key
      self.resize
      self.[]=(key, value)
    end
  end

  def [](key)
    hash_index = self.index(key, @items.length)
    @items[hash_index].value
  end

  def resize
    temp = @items
    @items = Array.new(temp.length * 2)
    temp.each do |item|
      if item != nil
        self.[]=(item.key, item.value)
      end
    end
  end

  # Returns a unique, deterministically reproducible index into an array
  def index(key, size)
    temp = key.sum % size
  end

  # Simple method to return the number of items in the hash
  def size
    @items.length
  end
end
