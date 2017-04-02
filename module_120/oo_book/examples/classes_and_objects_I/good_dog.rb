class GoodDog

  attr_accessor :name, :height, :weight

  def initialize(name, height, weight)
    @name = name
    @height = height
    @weight = weight
  end

  def change_info(n, h, w)
    self.name = n       #We need self, otherwise ruby will think we are creating new variables here
    self.height = h
    self.weight = w
  end

  def speak
    "#{name} says Arf!"
  end

  def info
    "#{name} weights #{weight} and is #{height} tall"
  end
end

sparky = GoodDog.new("Sparky", "3m", "60kg")
puts sparky.speak
puts sparky.name
sparky.name = "Spartacus"
puts sparky.name
puts sparky.speak

puts sparky.info

sparky.change_info("Rocky", "2m", "35kg")

puts sparky.info