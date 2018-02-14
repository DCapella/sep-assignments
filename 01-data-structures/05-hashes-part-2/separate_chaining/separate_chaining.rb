require_relative 'linked_list'

class SeparateChaining
  attr_reader :max_load_factor

  def initialize(size)
    @max_load_factor = 0.7
    @items = Array.new(size)
  end

  def []=(key, value)
    node_item = Node.new(key, value)
    node_index = self.index(key, @items.length)
    if @items[node_index].nil?
      @items[node_index] = node_item
    end
  end

  def [](key)
    node_index = index(key, @items.length)
    @items[node_index].value
  end

  # Returns a unique, deterministically reproducible index into an array
  # We are hashing based on strings, let's use the ascii value of each string as
  # a starting point.
  def index(key, size)
    index = key.sum % size
  end

  # Calculate the current load factor
  def load_factor
    current_load_factor = self.size / @items.length
    if current_load_factor >= 0.75
      self.resize
      self.load_factor
    end
    current_load_factor
  end

  # Simple method to return the number of items in the hash
  def size
    count = 0
    for @items.each do |item|
      count += 1 unless item.nil?
    end
    count
  end

  # Resize the hash
  def resize
    temp_items = @items
    @items = Array.new(temp_items.length * 2)
    temp_items.each do |item|
      unless item.nil?
        self.[]=(item.key, item.value)
      end
    end
  end
end
