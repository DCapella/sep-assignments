require_relative 'node'

class LinkedList
  attr_accessor :head
  attr_accessor :tail

  def initialize
    @linked_list = Array.new
    @head = @linked_list[0]
    @tail = @linked_list[-1]
  end

  # This method creates a new `Node` using `data`, and inserts it at the end of the list.
  def add_to_tail(node)
    @linked_list << node
    self.update_head_tail()
  end

  # This method removes the last node in the lists and must keep the rest of the list intact.
  def remove_tail
    temp = @linked_list[-1]
    @linked_list.delete(temp)
    self.update_head_tail()
  end

  # This method prints out a representation of the list.
  def print
    @linked_list.each do |node|
      puts node.data
    end
  end

  # This method removes `node` from the list and must keep the rest of the list intact.
  def delete(node)
    @linked_list.delete(node)
    self.update_head_tail()
  end

  # This method adds `node` to the front of the list and must set the list's head to `node`.
  def add_to_front(node)
    @linked_list.insert(0, node)
    self.update_head_tail()
  end

  # This method removes and returns the first node in the Linked List and must set Linked List's head to the second node.
  def remove_front
    @linked_list.delete_at(0)
    update_head_tail
  end

  def update_head_tail
    @head = @linked_list[0]
    @head.next = @linked_list[1] if @linked_list.length > 0
    @tail = @linked_list[-1]
  end
end
