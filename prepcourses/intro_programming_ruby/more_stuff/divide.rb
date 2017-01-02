def divide (first_number, second_number)
    begin
      result = first_number / second_number
      puts "#{first_number} divided by #{second_number} is #{result}"
    rescue ZeroDivisionError => e
      puts "Error dividing #{first_number} by #{second_number}"
      puts e.message
    end
end

divide(4, 2)
divide(10, 0)
divide(30, 5)