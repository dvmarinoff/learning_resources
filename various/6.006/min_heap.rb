class MinHeap

  def initialize(xs)
    @xs = xs
    @size = xs.length
  end

  def getLeftChildIndex(i)
    (i * 2) + 1
  end

  def getRightChildIndex(i)
    (i * 2) + 2
  end

  def getParentIndex(i)
    (i - 1) / 2
  end

  def getLeftChild(i)
    @xs[getLeftChildIndex(i)]
  end

  def getRightChild(i)
    @xs[getRightChildIndex(i)]
  end

  def getParent(i)
    @xs[getParentIndex(i)]
  end

  def hasLeftChild(i)
    getLeftChildIndex(i) < size
  end

  def hasRightChild(i)
    getRightChildIndex(i) < size
  end

  def hasParent(i)
    getParentIndex(i) >= size
  end

  def swap(i, j)
    temp = @xs[i]
    @xs[i] = @xs[j]
    @xs[j] = temp
  end

  def peak
    if size == 0
      puts "not a single x in xs"
    end
    @xs[0]
  end

  def poll
    if size == 0
      puts "not a single x in xs"
    end

    x = @xs[0]
    @xs[0] = @xs[@size - 1]
    @size -1;

    heapifyDown()

    x
  end

  def add(x)
    @xs.push(x)
    @size+1
    heapifyUp()
  end

  def heapifyDown
    i = 0

    while hasLeftChild(i)
      smallerChildIndex = getLeftIndex(i)

      if hasRightChild(i) && rightChild(i) < leftChild(i)
        smallerChildIndex = getRightChildIndex(i)
      end

      if @xs[i] < @xs[smallerChildIndex]
        return;
      else
        swap(i, smallerChildIndex)
      end
      i = smallerChildIndex
    end
  end

  def heapifyUp
    i = size - 1

    while hasParent(i) && parent(i) > @xs[i]
      swap(getParentIndex(i), i)
      i = getParentIndex()
    end

  end

end

xs = [3,4,8,9,7,10,0,15,20,13]

mh = MinHeap.new(xs)

puts "#{20} #{mh.getRightChild(3)}"
puts "#{15} #{mh.getLeftChild(3)}"
puts "#{9} #{mh.getParent(8)}"
puts "#{9} #{mh.getParent(7)}"
puts "#{3} #{mh.getParent(1)}"
puts "#{3} #{mh.getParent(2)}"
puts "#{8} #{mh.getParent(5)}"
puts "#{8} #{mh.getParent(6)}"

mh.heapifyUp
