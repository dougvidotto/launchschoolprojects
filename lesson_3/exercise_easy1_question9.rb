flintstones = { "Fred" => 0, "Wilma" => 1, "Barney" => 2, "Betty" => 3, "BamBam" => 4, "Pebbles" => 5 }

#Solution 1:
flintstones = flintstones.to_a.fetch(2)
p flintstones

#Solution 2:
flintstones = { "Fred" => 0, "Wilma" => 1, "Barney" => 2, "Betty" => 3, "BamBam" => 4, "Pebbles" => 5 }

flintstones.each do |key, value|
  if (key == 'Barney')
    flintstones = [key, value]
  end
end

p flintstones

#Solution 3
flintstones = { "Fred" => 0, "Wilma" => 1, "Barney" => 2, "Betty" => 3, "BamBam" => 4, "Pebbles" => 5 }
flintstones = flintstones.assoc("Barney")

p flintstones
