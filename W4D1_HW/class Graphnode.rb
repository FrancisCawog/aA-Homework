class GraphNode
    attr_accessor :val, :neighbors

    def initialize(val)
      self.val = val
      self.neighbors = []
    end

    def bfs(starting_node, target_value, visited = [])
        return nil if visited.include?(starting_node)
        return starting_node if starting_node == target_value

        visited << starting_node
        
        starting_node.neighbors.each do |neighbor|
            return bfs(neighbor, target_value,visited)
        end
    end
end

a = GraphNode.new('a')
b = GraphNode.new('b')
c = GraphNode.new('c')
d = GraphNode.new('d')
e = GraphNode.new('e')
f = GraphNode.new('f')
a.neighbors = [b, c, e]
c.neighbors = [b, d]
e.neighbors = [a]
f.neighbors = [e]