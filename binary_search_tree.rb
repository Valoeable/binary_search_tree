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

    def insert(value)
        inserted_node = Node.new(value)
        if @root.nil?
            @root = inserted_node
            return
        end

        prev_node = nil
        curr_node = @root
        while curr_node
            if(curr_node.data > value)
                prev_node = curr_node
                curr_node = curr_node.left
            elsif (curr_node.data < value)
                prev_node = curr_node
                curr_node = curr_node.right
            end
        end
        if prev_node.data > value
            prev_node.left = inserted_node
        else
            prev_node.right = inserted_node
        end
    end

    def delete(value, curr_root = @root)
        return curr_root if curr_root.nil?

        if curr_root.data > value
            curr_root.left = delete(value, curr_root.left)
        elsif curr_root.data < value
            curr_root.right = delete(value, curr_root.right)
        else
            return root.right if root.left.nil?
            return root.left if root.right.nil?

            successor_p = curr_root
            successor = curr_root.right

            while successor.left
                successor_p = successor
                successor = successor.left
            end

            if successor_p != curr_root
                successor_p.left = successor.right
            else
                successor_p.right = successor.left
            end

            curr_root.data = successor.data

            curr_root
        end
    end

    def find(value)
        curr_node = @root
        while curr_node.data != value
            if curr_node.data > value
                curr_node = curr_node.left
            elsif curr_node.data < value
                curr_node = curr_node.right
            end
        end
        curr_node
    end

    def level_order(queue = [])
        return if @root.nil?

        queue.push(@root)
        while queue.length.nonzero?
            current = queue.first
            print(" #{current.data} ")
            queue.push(current.left) unless current.left.nil?
            queue.push(current.right) unless current.right.nil?
            queue.shift
        end
    end
    
    def inorder(node = @root)
        return if node.nil?
    
        print inorder(node.left)
        print(" #{node.data} ")
        print inorder(node.right)
    end

    def preorder(node = @root)
        return if node.nil?
    
        print(" #{node.data} ")
        print preorder(node.left)
        print preorder(node.right)
    end
    
    def postorder(node = @root)
        return if node.nil?
    
        print postorder(node.left)
        print postorder(node.right)
        print(" #{node.data} ")
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

bst.insert(20)

bst.pretty_print
bst.level_order
print("\n")
bst.inorder
print("\n")
bst.preorder
print("\n")
bst.postorder
