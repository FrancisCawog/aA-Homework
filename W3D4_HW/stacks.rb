class Stack
    def initialize(stack_samp)
        @stack_samp = stack_samp
    end

    def push(el)
        @stack_samp << el
    end

    def pop
        @stack_samp.pop
    end

    def peek
        return @stack_samp.last
    end
end

class Queue
    def initialize(queue_array)
        @queue_array = queue_array
    end

    def enqueue(el)
        @queue_array << el
    end

    def dequeue
        @queue_array.shift
    end

    def peek
        return @queue_array.last
    end
end

class Map
    def initialize(map_sample)
        @map_sample = map_sample
    end

    def set(key, value)
        @map_sample[key] = value
    end 

    def get(key)
        @map_sample(key)
    end

    def delete(key)
        @map_sample.delete(key)
    end

    def show
        return @map_sample.last
    end
end