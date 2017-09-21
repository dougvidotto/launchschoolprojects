class Prime
  def self.nth(quantity)
    raise ArgumentError if quantity.to_i < 1
    prime_numbers = [2]
    possible_prime = 3
    while prime_numbers.size < quantity
      
      primes_shorter_than_possible_prime = prime_numbers.take_while do 
        |prime_num| prime_num <= Math.sqrt(possible_prime).to_i
      end
      
      prime_numbers << possible_prime unless primes_shorter_than_possible_prime.any? do 
        |prime_num| possible_prime % prime_num == 0
      end
      
      possible_prime += 2
    end
    prime_numbers[quantity - 1]
  end
end
