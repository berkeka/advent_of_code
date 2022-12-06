INPUT_FILE_NAME = File.join(File.dirname(__FILE__), 'input.txt')
input = File.read(INPUT_FILE_NAME)

input = input.chomp
length = input.length
PACKET_LENGTH = 4

needed_length = length - (PACKET_LENGTH - 1)

 # 4 for first step

result = -1

needed_length.times do |i|
  packet = input.slice(i, PACKET_LENGTH)

  # + 3 for end of slice
  # + 1 for index starting from 1
  result = i + 3 + 1; break if packet.chars.uniq.count == 4
end

p result
