#Now, using the same array from #2, use the select method to extract all odd numbers into a new array.

new_array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10].select {|item| (item % 2) == 0 }
p new_array