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
    elsif @items[node_index].key != key
      @items[node_index].next << node_item
    end
  end

  def [](key)
    node_index = index(key, @items.length)
    if @items[node_index].key == key || @items[node_index].next.empty?
      return @items[node_index].value
    else
      @items[node_index].next.each do |node|
        return node.value if node.key == key
      end
    end
  end

  # Returns a unique, deterministically reproducible index into an array
  # We are hashing based on strings, let's use the ascii value of each string as
  # a starting point.
  def index(key, size)
    index = key.sum % size
  end

  # Calculate the current load factor
  def load_factor
    current_load_factor = Float(self.size_not_nil) / Float(self.size)
    if current_load_factor >= 0.75
      self.resize
      return self.load_factor
    end
    current_load_factor
  end

  # Simple method to return the number of items in the hash
  def size
    @items.length
  end

  def size_not_nil
    count = 0
    @items.each do |item|
      if !item.nil?
        count += 1
        if !item.next.empty?
          count += item.next.length
        end
      end
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
        unless item.next.empty?
          item.next.each do |i|
            self.[]=(i.key, i.value)
          end
        end
      end
    end
  end
end
