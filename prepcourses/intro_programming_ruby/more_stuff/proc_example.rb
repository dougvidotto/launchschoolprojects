def call_a_proc (proc)
  [1, 2, 3, 4, 5].each do |number|
    proc.call(number)
  end
end

simple_proc = Proc.new do |number|
  puts "Simple proc being used. It was called inside a method passing the number #{number}"
end

call_a_proc(simple_proc)