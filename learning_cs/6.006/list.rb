class Node
  attr_accessor :value, :next, :prev

  def initialize(value)
    @value = value
    @next = nil
    @prev = nil
  end
end

class List

  def initialize
    @head = nil
    @tail = nil
    @size = 0
  end

  def first
    @head && @head.value
  end

  def last
    @tail && @tail.value
  end

  def push(node)
    node = Node.new(node)
    @head = @head || node

    if @tail
      @tail.next = node
      node.prev = @tail
    end

    @tail = node

    @size +=1
    self
  end

  def cons(node)
    node = Node.new(node)
    head_prime = @head
    node.next = head_prime
    @head = node
    @size += 1
    self
  end

  def rest
    list_prime = List.new
    curr_node = @head.next
    while curr_node
      list_prime.push(curr_node)
      curr_node = curr_node.next
    end
    list_prime
  end

  def each
    __each { |node| yield(node.value) }
  end

  def inspect
    each { |x| p x }
  end

  def reverse

  end

  def reverse!

  end

  def empty
    @head.nil?
  end

  def __each
    curr_node = @head
    while curr_node
      yield curr_node
      curr_node = curr_node.next
    end
  end
end

xs = List.new

xs.push(1)
xs.push(2)
xs.push(3)
xs.cons(0)

p "first: #{xs.first}"
p "last: #{xs.last}"

xs.inspect
