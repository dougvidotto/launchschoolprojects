class Prime
  def self.nth(position)
    raise ArgumentError if position.to_i < 1
    prime_numbers = []
    possible_prime = 2
    while prime_numbers.size < position
      possible_primes = prime_numbers.take_while {|num| num <= Math.sqrt(possible_prime).to_i }
      has_factors = possible_primes.select { |prime_num| possible_prime % prime_num == 0 }
      prime_numbers << possible_prime if has_factors.empty?
      possible_prime += 1
    end
    prime_numbers[position - 1]
  end
end
