INPUT_FILE_NAME = File.join(File.dirname(__FILE__), 'input.txt')
input = File.read(INPUT_FILE_NAME)

rucksacks = input.split("\n")

# PRIORITIES = [*('a'..'z'), *('A'..'Z')].each_with_index.inject({}) {|prio, (item, i)| prio[item] = i + 1} ???

PRIORITIES = {}
[*('a'..'z'), *('A'..'Z')].each_with_index {|item, i| PRIORITIES[item] = i + 1}

sum_of_priorities = rucksacks.each.inject(0) do |sum, rucksack|
  rucksack_size = rucksack.length
  split_index = (rucksack_size - 1) / 2

  first_compartment, second_compartment = [rucksack[0..split_index], rucksack[(split_index + 1)..-1]]

  first_compartment.chars.uniq.each do |item_from_first|
    sum += PRIORITIES[item_from_first] if second_compartment.include?(item_from_first)
  end

  sum
end

p sum_of_priorities
