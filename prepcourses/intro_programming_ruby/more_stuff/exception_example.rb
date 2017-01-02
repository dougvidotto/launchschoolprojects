names = ["Bob", "Douglas", "Paty", nil, "Jane"]

names.each do |name|
  begin
    puts "#{name} has #{name.length} letters in it."
  rescue
    puts "Something went wrong"
  end
end