class MyQueue
  attr_accessor :head
  attr_accessor :tail

  def initialize
    @queue = Array.new
    @head = @queue[0]
    @tail = @queue[-1]
  end

  def enqueue(element)
    @queue << element
    self.update_head_tail()
  end

  def dequeue
    temp = @queue[0]
    @queue.delete(temp)
    self.update_head_tail()
  end

  def empty?
    return true if @queue.length == 0
    false
  end

  def update_head_tail
    @head = @queue[0]
    @tail = @queue[-1]
  end
end
