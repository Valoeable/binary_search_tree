class Node
    attr_accessor :data, :left, :right

    def initialize(data)
        @data = data
        @left = nil
        @right = nil
    end
end

class Tree
    attr_accessor :root

    def initialize(array)
        sorted_array = array.sort.uniq
        @root = build_tree(sorted_array)
    end

    def build_tree(array)

        return nil if array.empty?

        mid = (array.length - 1) / 2
        new_node = Node.new(array[mid])
        new_node.left = build_tree(array[0...mid])
        new_node.right = build_tree(array[(mid + 1)..-1])

        new_node

    end

    def pretty_print(node = root, prefix = '', is_left = true)
        pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
        puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
        pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
    end

end

array = Array.new(15) { rand(1..100) }
bst = Tree.new(array)

bst.pretty_print
