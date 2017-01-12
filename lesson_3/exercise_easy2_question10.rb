#Back in the stone age (before CSS) we used spaces to align things on the screen.
#If we had a 40 character wide table of Flintstone family members, how could we
#easily center that title above the table with spaces?

title = "Flintstone Family Members"

while title.length < 40
  title.prepend(" ")
  title << " "
end

puts title
