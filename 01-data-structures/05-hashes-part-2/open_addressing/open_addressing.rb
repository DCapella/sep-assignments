require_relative 'node'

class OpenAddressing
  attr_accessor :items
  def initialize(size)
    @items = Array.new(size)
  end

  def []=(key, value)
    node_item = Node.new(key, value)
    node_index = self.index(key, @items.length)
    if @items[node_index].nil?
      @items[node_index] = node_item
    elsif !@items.any? { |i| i.nil? }
      self.resize
      self.[]=(key, value)
    elsif @items[node_index].value != node_item.value
      node_index_next = self.next_open_index(node_index)
      @items[node_index_next] = node_item
    end
  end

  def [](key)
    key_index = self.index(key, @items.length)
    unless @items[key_index].key == key
      @items.each do |item|
        if !item.nil? && item.key == key
          return item.value
        end
      end
    end
    @items[key_index].value
  end

  # Returns a unique, deterministically reproducible index into an array
  # We are hashing based on strings, let's use the ascii value of each string as
  # a starting point.
  def index(key, size)
    index = key.sum % size
  end

  # Given an index, find the next open index in @items
  def next_open_index(index)
    for i in (0...@items.length)
      return i if @items[i].nil?
    end
    -1
  end

  # Simple method to return the number of items in the hash
  def size
    @items.length
  end

  # Resize the hash
  def resize
    temp_items = @items
    @items = Array.new(temp_items.length * 2)
    temp_items.each do |item|
      if item != nil
        self.[]=(item.key, item.value)
      end
    end
  end
end
