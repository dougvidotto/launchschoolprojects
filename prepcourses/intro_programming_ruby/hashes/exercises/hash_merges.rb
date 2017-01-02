first_hash = { languages: "Ruby", 
               framework: "Rails" 
             }
second_hash = { languages: "Java", 
                framework: "Play" 
              }

third_hash = { orms: "Hibernate", 
                SGBD: "MySQL" 
              }          

puts "Starting content:"

p "First hash:"
p first_hash
p "Second hash: "
p second_hash
p "Third hash: "
p third_hash

puts "Merging first hash with second without '!'"
first_hash.merge(second_hash)
p first_hash
p second_hash

puts "Merging first hash with second with '!'"
first_hash.merge!(second_hash)
p first_hash
p second_hash

puts "Merging First Hash with third without !"
first_hash.merge(third_hash)
p first_hash
p third_hash

puts "Merging First Hash with third with !"
first_hash.merge!(third_hash)
p first_hash
p third_hash
