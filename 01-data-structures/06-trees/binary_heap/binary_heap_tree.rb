require_relative 'node'

class BinaryHeapTree

  def initialize(root)
    @root = root
  end

  def insert(root, node, children=nil)
    next_children = []
    if children.nil?
      children = []
      children << root
    end
    children.each do |child|
      if child.left.nil?
        child.left = node
        next_children = []
        break
      elsif child.right.nil?
        child.right = node
        next_children = []
        break
      elsif child.left.rating < node.rating
        temp = child.left
        child.left = node
        next_children = []
        self.insert(root, temp)
      elsif child.right.rating < node.rating
        temp = child.right
        child.right = node
        next_children = []
        self.insert(root, temp)
      else
        next_children << child.left
        next_children << child.right
      end
    end
    unless next_children.empty?
      self.insert(root, node, next_children)
    end
  end

  # Recursive Depth First Search
  def find(root, data, delete=false)
    output = nil
    unless root.left.nil?
      if root.left.title == data
        unless delete
          output = root.left
        else
          root.left = nil
        end
      else
        output = self.find(root.left, data, delete)
      end
    end
    unless root.right.nil? || !output.nil?
      if root.right.title == data
        unless delete
          output = root.right
        else
          root.right = nil
        end
      else
        output = self.find(root.right, data, delete)
      end
    end
    output
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
