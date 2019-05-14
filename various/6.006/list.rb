# Node object holding pointers and a value
class Node
  attr_accessor :value, :next, :prev

  def initialize(value)
    @value = value
    @next = nil
    @prev = nil
  end
end

# Linked List
class List
  attr_reader :size
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
    @head ||= node

    if @tail
      @tail.next = node
      node.prev = @tail
    end

    @tail = node

    @size += 1
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
    node = @head.next
    while node
      list_prime.push(node)
      node = node.next
    end
    list_prime
  end

  def each
    __each { |node| yield(node.value) }
  end

  def reverse
    list_prime = List.new
    values = to_a.reverse!
    values.each { |value| list_prime.push(value) }
    list_prime
  end

  def reverse!
    curr = @head
    prev = nil

    while curr
      next_node = curr.next
      curr.next = prev
      prev = curr
      curr = next_node
    end

    @head = prev

    # __each do |node|
    #   node.prev, node.next = node.next, node.prev
    # end
    # @head, @tail = @tail, @head

    self
  end

  def empty
    @head.nil?
  end

  def to_a
    arr = []
    each { |n| arr.push(n) }
    arr
  end

  def to_s
    p to_a
  end

  def inspect
    to_a
  end

  def __each
    node = @head
    while node
      yield node
      node = node.next
    end
  end
end

xs = List.new

xs.push(1)
xs.push(2)
xs.push(3)
xs.push(4)
xs.cons(0)

p "first: #{xs.first}"
p "last: #{xs.last}"
p "size: #{xs.size}"

print "reverse elements: #{xs.inspect}"
xsr = xs.reverse
puts " -> #{xsr.inspect}"

print "reverse elements inplace: #{xs.inspect}"
xs.reverse!
puts " -> #{xs.inspect}"
