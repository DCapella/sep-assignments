require_relative 'node'

def find_kevin_bacon(start)
  node_list = []
  start.film_actor_hash.each do |node|
    if node_list.length <= 6 && node.include?('Kevin_Bacon')
      node_list << node
    end
  end
  node_list
end
