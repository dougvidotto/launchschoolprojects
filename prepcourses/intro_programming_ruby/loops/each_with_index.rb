def each_with_index (arr)
  index = 0;
  arr.each do |value|
    puts "#{index}. #{value}"
    index += 1
  end
end

simple_array = [1234, "Array", 98.9, "Inserting a sentence"]
each_with_index(simple_array)