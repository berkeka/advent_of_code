INPUT_FILE_NAME = File.join(File.dirname(__FILE__), 'input.txt')
input = File.read(INPUT_FILE_NAME)

rounds = input.split("\n")

OUTCOME_SCORES = {
  # Rock
  'X' => { 
    'A' => 3,
    'B' => 0,
    'C' => 6,
  },
  # Paper
  'Y' => {
    'A' => 6,
    'B' => 3,
    'C' => 0,
  },
  # Scissors
  'Z' => {
    'A' => 0,
    'B' => 6,
    'C' => 3,
  },
}

SELECTION_SCORES = {
  'X' => 1,
  'Y' => 2,
  'Z' => 3,
}

sum_of_points = rounds.each.inject(0) do |sum, round|
  opponent, us = round.split(' ')

  sum += (SELECTION_SCORES[us] + OUTCOME_SCORES[us][opponent])
end

p sum_of_points

