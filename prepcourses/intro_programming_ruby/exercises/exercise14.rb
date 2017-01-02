contact_data = [["joe@email.com", "123 Main st.", "555-123-4567"],
            ["sally@email.com", "404 Not Found Dr.", "123-234-3454"]]

contacts = {"Joe Smith" => {}, "Sally Johnson" => {}}

data_position = 0
contacts.each do |name, c_data|
  if name == "Sally Johnson"
    data_position = 1
  end
  c_data[:email] = contact_data[data_position][0]
  c_data[:address] = contact_data[data_position][1]
  c_data[:telephone] = contact_data[data_position][2]
end

p contacts