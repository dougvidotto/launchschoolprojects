puts "To verify if a hash has a specific value, we should use the method has_value?"

monuments = {"New York": "Statue of Liberty","Paris": "Eifel Tower", "Rio de Janeiro": "Cristo Redentor"}

puts "Giving the hash below:"
p monuments

puts "Using monuments.has_value?('Cristo Redentor')"
p monuments.has_value?('Cristo Redentor')

puts "Now trying to find a value that is not in the hash: monuments.has_value?('Pyramids')"
p monuments.has_value?('Pyramids')