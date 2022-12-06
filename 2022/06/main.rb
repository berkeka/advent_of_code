INPUT_FILE_NAME = File.join(File.dirname(__FILE__), 'input.txt')
input = File.read(INPUT_FILE_NAME)

input = input.chomp
length = input.length
PACKET_LENGTH = 14 # 4 was the length for step 1

needed_packet_length = length - (PACKET_LENGTH - 1)

result = -1

needed_packet_length.times do |i|
  packet = input.slice(i, PACKET_LENGTH)

  # + PACKET_LENGTH for end of slice
  # + 1 for index starting from 1
  result = i + (PACKET_LENGTH - 1) + 1; break if packet.chars.uniq.count == PACKET_LENGTH
end

p result
