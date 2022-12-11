INPUT_FILE_NAME = File.join(File.dirname(__FILE__), 'input.txt')
input = File.read(INPUT_FILE_NAME)

instructions = input.split("\n")
# p instructions

# [[instruction, remaining_cycle]]
execution_queue = []

instructions_enum = instructions.each

CYCLES = [20, 60, 100, 140, 180, 220]
signals = []
x = 1

(1..CYCLES.last).each do |i|
  # Start of cycle 
  signals << i * x if CYCLES.include?(i)

  # Get next execution
  begin
    ins = instructions_enum.next
    case ins.split
    in ["noop"]
      execution_queue << [ins, 1]
    in ["addx", value] 
      execution_queue << [ins, 2]
    end
  rescue StopIteration
  end

  # End of cycle
  execution = execution_queue.first
  next if execution.nil?
  case execution.first.split
  in ["noop"]
    execution_queue.shift
  in ["addx", value]
    if execution.last == 1
      x += value.to_i
      execution_queue.shift
    end
    execution_queue.first[1] = 1 if execution.last == 2
  end
end

p signals
p signals.sum
