class Max_Heap
  def initialize(xs = [])
    @xs = xs
    @size = 0
  end

  def inspect
    @xs
  end

  def push(x)
    @xs.push(x)
    @size += 1
  end

  def parent_key(i)
    i / 2
  end

  def left_child_key(i)
    2 * i
  end

  def right_child_key(i)
    (2 * i) + 1
  end

  def parent(i)
    @xs[parent(i)]
  end

  def left_child(i)
    @xs[left_child_key(i)]
  end

  def right_child(i)
    @xs[right_child_key(i)]
  end

  def leaf?(i)
    i >= @size / 2
  end

  def swap(i, j)
    temp = @xs[i]
    @xs[i] = @xs[j]
    @xs[j] = temp
  end

  def max_heapify(i)
    left = left_child_key(i)
    right = right_child_key(i)
    if left <= @size && @xs[right] > @xs[i]
      
    end
  end

  def build_max_heapify

  end
end
