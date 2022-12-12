INPUT_FILE_NAME = File.join(File.dirname(__FILE__), 'input.txt')
input = File.read(INPUT_FILE_NAME)

monkeys = input.split("\n\n")

ROUND_COUNT = 20

monkeys.map!.with_index do |monkey, i|
  lines = monkey.split("\n")
  lines.map! {|line| line.split(":").last}

  {
    items: lines[1].split(",").map(&:to_i),
    operation: lines[2].split("=").last.strip,
    test: lines[3].split.last.to_i,
    if_true: lines[4].split.last.to_i,
    if_false: lines[5].split.last.to_i,
    inspected_count: 0,
  }
end

ROUND_COUNT.times do
  monkeys.each do |monkey|
    monkey[:items].length.times do
      # Get current item
      current_item = monkey[:items].shift
      monkey[:inspected_count] += 1
  
      # Execute operation
      case monkey[:operation].split
      in ["old", operator, "old"]
        current_item = current_item.method(operator).(current_item)
      in ["old", operator, value]
        current_item = current_item.method(operator).(value.to_i)
      end
  
      # Monkey is bored divide by 3
      current_item /= 3
  
      # Run test
      if current_item % monkey[:test] == 0
        monkeys[monkey[:if_true]][:items].push current_item
      else
        monkeys[monkey[:if_false]][:items].push current_item
      end
    end
  end
end

# Sort by inspected count
# TODO Can use a better implementation
sorted_monkeys = monkeys.sort_by {|monkey| -monkey[:inspected_count]}
top_2_monke = sorted_monkeys.slice(0, 2)

mult = top_2_monke.each.inject(1) {|mult, m| mult *= m[:inspected_count]}

p mult

