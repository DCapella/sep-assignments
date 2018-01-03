class MyStack
  attr_accessor :top

  def initialize
    @stack = Array.new
    self.top = nil
  end

  def push(item)
    @stack << item
    self.update_top()
  end

  def pop
    temp = @stack[-1]
    @stack.delete(temp)
    self.update_top()
    temp
  end

  def empty?
    return true if @stack.length == 0
    false
  end

  def update_top
    self.top = @stack[-1]
  end
end
