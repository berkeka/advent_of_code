INPUT_FILE_NAME = File.join(File.dirname(__FILE__), 'input.txt')
input = File.read(INPUT_FILE_NAME)

lines = input.split("\n")

TOTAL_DISK_SPACE = 70000000
NEEDED_SPACE = 30000000

directory_stack = []
sizes = Hash.new(0)

lines.each do |line|
  case line.split(" ")
  in ['$', 'cd', '..']
    directory_stack.pop
  in ['$', 'cd', dir]
    directory_stack.push(dir)
  in ['$', 'ls']
  in ['dir', dir]
  in [file_size, file_name]
    # This implementation didn't account for the fact different directories cant have
    # directories with same name in them
    # directory_stack.each do |dir|
    #   sizes[dir] += file_size.to_i
    # end

    directory_stack.length.times do |i|
      # Add size to every directory in the stack
      sizes[directory_stack[0..i]] += file_size.to_i
    end
  end
end

sum_of_sizes = sizes.each.inject(0) do |sum, (dir, size)|
  sum += size if size <= 100000

  sum
end

unused_space = TOTAL_DISK_SPACE - sizes[["/"]]
deleted_dir_space = 70000000

sizes.each do |_, size|
  deleted_dir_space = size if unused_space + size >= NEEDED_SPACE && size < deleted_dir_space
end

p sum_of_sizes

p deleted_dir_space
