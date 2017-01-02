def execute(block)
  block.call
end

execute { puts "Hello from inside the execute method!" }

#'execute' parameter doesnt have a ampersand (&), so block is not really a block of code to be executed