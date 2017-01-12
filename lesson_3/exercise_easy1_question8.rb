flintstones = ["Fred", "Wilma"]
flintstones << ["Barney", "Betty"]
flintstones << ["BamBam", "Pebbles"]

#flintstones array is now ["Fred, "Wilma", ["Barney", "Betty"], ["BamBam", "Pebbles"]].

#To make this an unested array, we can do as following:

p flintstones.flatten!
