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

REVERSED_OUTCOME_SCORES = {
  # Rock
  'X' => {
    'A' => 3,
    'B' => 6,
    'C' => 0,
  },
  # Paper
  'Y' => {
    'A' => 0,
    'B' => 3,
    'C' => 6,
  },
  # Scissors
  'Z' => {
    'A' => 6,
    'B' => 0,
    'C' => 3,
  },
}

SELECTION_SCORES = {
  'X' => 1,
  'Y' => 2,
  'Z' => 3,
}

DECRYPTION = {
  'A' => 'X',
  'B' => 'Y',
  'C' => 'Z',
}

ENCRYPTION = {
  'X' => 'A',
  'Y' => 'B',
  'Z' => 'C',
}

WIN_SITUATION = {
  'X' => 0,
  'Y' => 3,
  'Z' => 6,
}

sum_of_points = rounds.each.inject(0) do |sum, round|
  opponent, us = round.split(' ')

  sum += (SELECTION_SCORES[us] + OUTCOME_SCORES[us][opponent])
end

sum_of_points_2 = rounds.each.inject(0) do |sum, round|
  opponent, us = round.split(' ')
  decrypted_opponent = DECRYPTION[opponent]

  reversed = REVERSED_OUTCOME_SCORES[decrypted_opponent].map(&:reverse).to_h

  selection = reversed[WIN_SITUATION[us]]

  sum += (WIN_SITUATION[us] + SELECTION_SCORES[DECRYPTION[selection]])
end

p sum_of_points

p sum_of_points_2

