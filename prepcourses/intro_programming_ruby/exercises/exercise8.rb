#Creating hash with collons
hash_with_collons = {dog: "Fido", cat: "Whiskas", bird: "Road Runner"}
hash_with_arrow = {:dog => "Fido", :cat => "Whiskas", :bird => "Road Runner"}

hash_with_collons.each do |key, value|
  puts "#{key}: #{value} "
end

hash_with_arrow.each do |key, value|
  puts "#{key}: #{value} "
end