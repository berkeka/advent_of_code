INPUT_FILE_NAME = File.join(File.dirname(__FILE__), 'input.txt')
input = File.read(INPUT_FILE_NAME)

foods_by_elves = input.split("\n\n")

index = -1
max_calories = 0
max_3_calories = [0, 0, 0]

foods_by_elves.each_with_index do |foods_str, i|
  foods = foods_str.split("\n")
  sum_of_calories = foods.each.inject(0) {|sum, calorie| sum += calorie.to_i}
  
  if max_calories < sum_of_calories
    index = i
    max_calories = sum_of_calories
  end

  if max_3_calories[0] < sum_of_calories
    max_3_calories.unshift(sum_of_calories)
    max_3_calories.pop
  elsif max_3_calories[1] < sum_of_calories
    max_3_calories[2] = max_3_calories[1]
    max_3_calories[1] = sum_of_calories
  elsif max_3_calories[2] < sum_of_calories
    max_3_calories[2] = sum_of_calories
  end
end

p max_calories

p max_3_calories.sum
