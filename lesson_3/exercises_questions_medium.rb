#Question 1

#Let's do some "ASCII Art" (a stone-age form of nerd artwork from back in the days before computers had video screens).

#For this exercise, write a one-line program that creates the following output 10 times, with the subsequent line indented 1 space to the right:

#The Flintstones Rock!
 #The Flintstones Rock!
  #The Flintstones Rock!

puts "Question 1 solution:"

10.times {|n| puts "The Flinstones Rock!".prepend(" " * n)}

puts "---------------------------------------------------------"

puts "Question 2 solution:"

puts "One way to correct it is putting to_s after parentheses"
puts "the value of 40 + 2 is " + (40 + 2).to_s
puts "Another solution is to use interpolation "
puts "the value of 40 + 2 is #{(40 + 2)}"

puts "---------------------------------------------------------"

puts "Question 3 solution:"
puts "Changing to a while loop, and entering it only if dividend is > than 0, it will not break"
def factors(number)
  dividend = number
  divisors = []
  while dividend > 0
    divisors << number / dividend if number % dividend == 0
    dividend -= 1
  end
  divisors
end

puts "What is the purpose of the number % dividend == 0 ?"
puts "Answer: % calculates the modulus of a number. So if it results in zero, it means that number is a dividend"

puts "What is the purpose of the second-to-last line in the method (the divisors before the method's end)?"
puts "Answer: The divisors is there to be returned by factors method"



puts"\n\n-------------------------------------------------------"

puts "Question 4:"

puts "Yes, there is a difference between the two methods. If only the + is used, a new array will be returned
       but the caller won't be changed. So to this program to work, it's better to use <<, so the array will be modified"

puts"\n\n-------------------------------------------------------"

puts "Question 5:"

puts "Methods doesn't have access to variables outside of their scope, unles they are constants. So, to fix this code
      the variable limit should be declared inside 'fib' method"

def fib(first_num, second_num)
  limit = 15
  while second_num < limit
    sum = first_num + second_num
    first_num = second_num
    second_num = sum
  end
  sum
end

result = fib(0, 1)
puts "result is #{result}"


puts"\n\n-------------------------------------------------------"

puts "Question 6:"
puts "Answer: In this case I would first change the method's name to something more clearer like: 'add_rubatanda'.
      Then, I would insert a exclamation point (!) after the method name to make it clear to other developers that
      this method is altering the arguments being passed"

puts"\n\n-------------------------------------------------------"

puts "Qeustion 6:"

puts "The answer will be 42 - 8 = 34"

puts"\n\n-------------------------------------------------------"

puts "Question 8:"

puts ""
