INPUT_FILE_NAME = File.join(File.dirname(__FILE__), 'input.txt')
input = File.read(INPUT_FILE_NAME)

pairs = input.split("\n")

class Range
  def covers_range?(range)
    raise 'Use ranges as input' unless range.is_a?(Range)
    return true if self.first <= range.first && self.last >= range.last

    false
  end

  def overlaps?(range)
    raise 'Use ranges as input' unless range.is_a?(Range)
    if self.first <= range.first && (self.last >= range.first && self.last <= range.last) || 
      range.first <= self.first && (range.last >= self.first && range.last <= self.last) ||
      self.covers_range?(range) || range.covers_range?(self)
      return true
    end
    false
  end
end

sum_of_overlaps = pairs.each.inject(0) do |sum, pair|
  first_range, second_range = (pair.split(",")).map do |elf| 
    range_info = elf.split("-")
    Range.new(range_info[0].to_i, range_info[1].to_i)
  end

  sum += 1 if first_range.covers_range?(second_range) || second_range.covers_range?(first_range)

  sum
end

sum_of_overlaps_2 = pairs.each.inject(0) do |sum, pair|
  first_range, second_range = (pair.split(",")).map do |elf| 
    range_info = elf.split("-")
    Range.new(range_info[0].to_i, range_info[1].to_i)
  end

  sum += 1 if first_range.overlaps?(second_range)

  sum
end

p sum_of_overlaps
p sum_of_overlaps_2
