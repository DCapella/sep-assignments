require_relative 'node'

class BinarySearchTree

  def initialize(root)
    @root = root
  end

  def insert(root, node)
    if root.rating < node.rating
      if root.right.nil?
        root.right = node
      else
        self.insert(root.right, node)
      end
    else
      if root.left.nil?
        root.left = node
      else
        self.insert(root.left, node)
      end
    end
  end

  # Recursive Depth First Search
  def find(root, data, delete=false)
    unless root.left.nil?
      if root.left.title == data
        unless delete
          return root.left
        else
          root.left = nil
        end
      else
        return self.find(root.left, data, delete)
      end
    end
    unless root.right.nil?
      if root.right.title == data
        unless delete
          return root.right
        else
          root.right = nil
        end
      else
        return self.find(root.right, data, delete)
      end
    end
  end

  def delete(root, data)
    self.find(root, data, true)
  end

  # Recursive Breadth First Search
  def printf(output=nil, children=nil)
    if output.nil?
      output = []
      children = []
      output << @root.text
      children << @root
    end
    next_children = []
    children.each do |node|
      unless node.left.nil?
        output << node.left.text
        next_children << node.left
      end
      unless node.right.nil?
        output << node.right.text
        next_children << node.right
      end
    end
    unless next_children.empty?
      printf(output, next_children)
    else
      puts output.join("\n")
    end
  end
end
