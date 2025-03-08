module Enumerable
  def my_all?
    return true unless block_given? # If no block, return true (like Ruby's all?)
    my_each do |element|
      return false unless yield(element) # Return false if any element fails
    end
    true # All elements passed
  end

  def my_any?
    return false unless block_given? # If no block, return false (like Ruby's any?)
    my_each do |element|
      return true if yield(element) # Return true if any element matches
    end
    false # No elements matched
  end

  def my_count
    if block_given?
      count = 0
      my_each do |element|
        count += 1 if yield(element) # Increment count if element satisfies the block
      end
      count
    else
      my_each { |_| } # Iterate to ensure compatibility, but we just need the size
      size # Return the size of the enumerable
    end
  end

  def my_each_with_index
    return self unless block_given? # Return self if no block
    index = 0
    my_each do |element|
      yield(element, index) # Yield element and its index to the block
      index += 1
    end
    self # Return the original enumerable
  end

  def my_inject(initial_value = nil)
    return nil unless block_given? # Return nil if no block (optional behavior)
    accumulator = initial_value
    first_pass = true if initial_value.nil?
    my_each do |element|
      if first_pass
        accumulator = element
        first_pass = false
      else
        accumulator = yield(accumulator, element) # Update accumulator with block result
      end
    end
    accumulator
  end

  def my_map
    return self unless block_given? # Return self if no block (optional behavior)
    result = []
    my_each do |element|
      result << yield(element) # Collect transformed elements
    end
    result
  end

  def my_none?
    return true unless block_given? # If no block, return true (like Ruby's none?)
    my_each do |element|
      return false if yield(element) # Return false if any element matches
    end
    true # No elements matched
  end

  def my_select
    return self unless block_given? # Return self if no block (optional behavior)
    result = []
    my_each do |element|
      result << element if yield(element) # Collect elements that match the condition
    end
    result
  end
end

class Array
  def my_each
    return self unless block_given? # Return self if no block
    for i in 0...length
      yield(self[i]) # Yield each element to the block
    end
    self # Return the array
  end
end