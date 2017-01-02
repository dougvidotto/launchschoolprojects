family = {  
            uncles: ["bob", "joe", "steve"],
            sisters: ["jane", "jill", "beth"],
            brothers: ["frank","rob","david"],
            aunts: ["mary","sally","susan"]
          }

immediate_members = family.select { |k, v| k == :sisters || k == :brothers}
p immediate_members.values.flatten