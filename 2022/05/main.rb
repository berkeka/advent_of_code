INPUT_FILE_NAME = File.join(File.dirname(__FILE__), 'input.txt')
input = File.read(INPUT_FILE_NAME)

grid, instructions_str = input.split("\n\n")

instructions = instructions_str.split("\n")

levels = grid.split("\n")
number_of_stacks = levels.pop.gsub(' ', '').length

stacks = []
number_of_stacks.times { stacks << [] }

levels.each do |level|
   level.chars.each_slice(4).with_index do |block, index|
    block_name = block[1]
    stacks[index] << block_name if block_name != ' '
   end
end

stacks.map(&:reverse!)

instructions.each do |instruction|
  # move 1 from 7 to 4
  count, from, to = *instruction.scan(/move ([0-9]+) from ([0-9]+) to ([0-9]+)/).to_a[0].map(&:to_i)
  # Pop from stack
  count.times do
    popped = stacks[from - 1].pop
    stacks[to - 1].push(popped)
  end

  # FIX-ME use slice for better performance ???

  # stack_length = stacks[from - 1].count
  # p stack_length
  # slice = stacks[from - 1].slice!(stack_length - count..stack_length)

  # # Push to new stack
  # stacks[to - 1].push(*slice)
end

# Results in a segfault in 3.0.0??? 
# result = stacks.map.inject("") {|str, stack| str.push(stack[-1])}

# undefined method `+' for nil:NilClass ???
# result = stacks.map.inject("") do |str, stack| 
#   str += stack[-1] unless stack[-1].nil?
# end

result = stacks.each.inject("") do |str, stack|
  str += stack[-1]
end

p result
