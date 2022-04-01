# Authors: Jordan Greenbaum, Jacob Krawitz
# Date: 03 December 2021
# Description: A standard doubly linked list class.

class LinkedList include Enumerable
    # make instance variables @head and @tail publicly readable
    attr_reader :head, :tail
    
    def initialize
        @head = nil
        @tail = nil
        @size = 0
    end

    # get the value at the specified index
    def get(index)
        # if index is outside the range, return nil
        if index >= @size or index < 0
            return nil
        end
        
        # iterate through the list until desired index is reached
        current = @head
        for i in 0...index do
            current = current.get_next
        end

        # return the value at the specified index
        current.get_value
    end

    # get the value at the head
    def get_first
        @head.get_value
    end

    # get the value at the tail
    def get_last
        @tail.get_value
    end

    # add a value to the front of the list
    def add_first(value)
        # create a new node
        node = Node.new(value)

        # if the list is empty, update the head and tail
        if @size == 0
            @head = node
            @tail = node
        # otherwise, link the new node to the front
        else
            node.set_next(@head)
            @head.set_prev(node)
            @head = node
        end

        # increase the size
        @size += 1
    end

    # add a value to the back of the list
    def add_last(value)
        # create a new node
        node = Node.new(value)

        # if the list is empty, update the head and tail
        if @size == 0
            @head = node
            @tail = node
        # otherwise, link the new node to the back
        else
            node.set_prev(@tail)
            @tail.set_next(node)
            @tail = node
        end

        # increase the size
        @size += 1
    end

    # insert a value in the middle of the list
    def insert(index, value)

        node = Node.new(value)

        # if index is outside the range, return nil
        if index >= @size or index < 0
            return nil
        end
        
        # iterate through the list until desired index is reached
        current = @head
        for i in 0...index-1 do
            current = current.get_next
        end

        #Set new node's next to current's next
        node.set_next(current.get_next)
        
        #Set current's next's previous to new node 
        current.get_next.set_prev(node)

        #Set new node's previous to current
        node.set_prev(current)

        #Set current's next to new node
        current.set_next(node)

        @size += 1

    end

    # get the current size of the list
    def size
        @size
    end

    # remove all values from the list
    def clear!
        @head = nil
        @tail = nil
        @size = 0
    end

    # remove the first value in the list
    def remove_first
       
        #Set head to head's original next, effectively skipping the first value
        @head = @head.get_next
        @head.set_prev(nil)

        #Decrease size
        @size -= 1
    end

    # remove the last value in the list
    def remove_last
        # set the tail to the previous value
        @tail = @tail.get_prev
        
        # remove the new tail's forward connection to make it the last node
        @tail.set_next(nil)

        # decrease the size
        @size -= 1
    end

    # remove the value at the specified index
    def remove_at(index)

        # if index is outside the range, return nil
        if index >= @size or index < 0
            return nil
        end
        
        if index == 0
            self.remove_first

        elsif index == @size - 1
            self.remove_last

        else
            # iterate through the list until desired index is reached
            current = @head
            
            for i in 0...index-1 do
                current = current.get_next
            end

            # skip over the node so it gets removed by the garbage collector
            current.set_next(current.get_next.get_next)
            current.get_next.set_prev(current)

        end

        # decrease size
        @size -= 1

    end

    # change the value at the specified index
    def set(index, value)
        # if index is outside the range, return nil
        if index >= @size or index < 0
            return nil
        end
        
        # iterate through the list until desired index is reached
        current = @head
        for i in 0...index do
            current = current.get_next
        end

        # change the value
        current.set_value(value)

    end

    # remove the end of the list so that the remaining list has indices 0..index
    def sever!(index)
        # return a default value if index is out of bounds
        if (index >= @size or index < 0)
            return -1
        end

        # iterate to the desired index
        current = @head
        i = 0
        while i < index
            current = current.get_next
            i += 1
        end

        # make the specified index the tail and remove the forward connection
        @tail = current
        @tail.set_next(nil)

        # set the new size
        @size = index + 1
    end

    # override the method to convert this class into a string (works with the puts method)
    def to_s

        if @size == 0
            return "[]"
        end

        strHolder = "["

        current = @head

        # separate each value with a comma
        while current.get_next != nil
            strHolder << current.get_value.to_s << ", "
            current = current.get_next
        end
        strHolder << current.get_value.to_s << "]"

        return strHolder

    end

    # operator overload for square bracket indexing
    def [](index)
        self.get(index)
    end

    # operator overload for square bracket setting
    def []=(index, value)
        self.set(index,value)
    end

    # operator overload for merging two lists
    def +(other_list)
        list = LinkedList.new

        # add all values from this list to the new list
        current = @head

        while current != nil
            list.insert_last(current.get_value)
            current = current.get_next
        end
        
        # add all values from other list to the new list
        current = other_list.head

        while current != nil
            list.insert_last(current.get_value)
            current = current.get_next
        end
        
        return list
    end

    # apply some block function to each value in the list (satisfies the Enumerable module)
    def each(&block)
        current = @head

        while current != nil
            block.call(current.get_value)
            current = current.get_next
        end
    end
end

# Node class for storing values in the Linked List
class Node
    def initialize(val)
        @value = val
        @next = nil
        @prev = nil
    end

    def get_next
        @next
    end

    def set_next(next_node)
        @next = next_node
    end

    def get_prev
        @prev
    end

    def set_prev(prev_node)
        @prev = prev_node
    end

    def get_value
        @value
    end

    def set_value(new_value)
        @value = new_value
    end
end