words = ["laboratory", "experiment", "Pains Labyrinth", "elaborate", "polar bear"]

words.each do |word|
  if word =~ /lab/
    puts word
  end
end