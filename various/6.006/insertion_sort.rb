#   insert :: [Int], Int, Int -> [Int]
def insert(ys, x, i)
  # puts "#{i}: #{ys[i]} < #{x}"
  if i < 0
    return ys
  end
  if x > ys[i]
    ys.insert(i+1, x)
    return ys
  end
  if i == 0 && x < ys[i]
    ys.insert(0,x)
    return ys
  end

  insert(ys, x, i-1)
end

# xs is the unsorted input, ys is the sorted output
# start with key at xs[0] and move the key to the right
# while selecting an x and inserting it to ys in a sorted position
#   insertion_sort :: [Int], [], Int -> [Int]
def insertion_sort(xs, ys, key)
  if key > xs.length - 1
    return ys
  end
  if key == 0
    ys[0] = xs[0];
  else
    ys = insert(ys, xs[key], (ys.length - 1))
  end

  insertion_sort(xs, ys, key+1)
end

xs = [5,2,4,6,1,3,10,7,0,9]

sorted = insertion_sort(xs, [], 0)

puts "#{xs} -> #{sorted}"
