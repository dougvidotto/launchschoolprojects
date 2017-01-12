#Solution 1
ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 402, "Eddie" => 10 }

if (ages["Spot"] != nil)
  puts "Spot is present"
else
  puts "Spot is not present"
end

#Solution 2
ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 402, "Eddie" => 10 }

if (ages.key?("Spot"))
  puts "Spot is present"
else
  puts "Spot is not present"
end

#Solution 3
ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 402, "Eddie" => 10 }

if (ages.member?("Spot"))
  puts "Spot is present"
else
  puts "Spot is not present"
end

#Solution 4
ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 402, "Eddie" => 10 }

if (ages.include?("Spot"))
  puts "Spot is present"
else
  puts "Spot is not present"
end
