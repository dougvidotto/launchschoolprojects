class Dog
  def speak
    'bark!'
  end

  def swim
    'swimming!'
  end
end

class BullDog < Dog
	def swim
		"can't swim!"
	end
end

teddy = Dog.new
puts teddy.speak           # => "bark!"
puts teddy.swim

hover = BullDog.new
puts hover.speak
puts hover.swim