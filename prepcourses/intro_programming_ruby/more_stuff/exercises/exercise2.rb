def execute(&block)
  block
end

execute { puts "Hello from inside the execute method!" }

#The code above will not print anything, since 'block' inside 'execute' method is not calling 'call' method. To properly works,
#it should be like this: block.call