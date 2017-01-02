def contains_anagram_word (word, group)
  for i in group
    if word.chars.sort == i.chars.sort
      return true
    end
  end
  return false
end

words =  ['demo', 'none', 'tied', 'evil', 'dome', 'mode', 'live',
          'fowl', 'veil', 'wolf', 'diet', 'vile', 'edit', 'tide',
          'flow', 'neon']

anagram_groups = []

words.each do |word|
  if anagram_groups.empty?
    anagram_groups.push([word])
  else
    found = false
    for anagram_group in anagram_groups
      if contains_anagram_word(word, anagram_group)
        anagram_group.push(word)
        found = true
      end
    end
    if !found
      anagram_groups.push([word])
    end
  end
end

for i in anagram_groups
  p i
end