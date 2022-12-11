INPUT_FILE_NAME = File.join(File.dirname(__FILE__), 'input.txt')
input = File.read(INPUT_FILE_NAME)

steps = input.split("\n")
steps.map! {|e| d, m = e.split; [d, m.to_i] }

class Piece
  attr_accessor :x, :y
  def initialize
    @x = 0
    @y = 0
  end

  def move(direction)
    case direction
    when "R"
      @x += 1
    when "L"
      @x -= 1
    when "U"
      @y += 1
    when "D"
      @y -= 1
    end
  end

  def move_towards(head)
    if x == head.x
      move("D") if top_of?(head)
      move("U") if down_of?(head)
    elsif y == head.y
      move("R") if left_of?(head)
      move("L") if right_of?(head)
    else
      if right_of?(head) && top_of?(head)
        move("L")
        move("D")
      elsif left_of?(head) && down_of?(head)
        move("R")
        move("U")
      elsif right_of?(head) && down_of?(head)
        move("L")
        move("U")
      elsif left_of?(head) && top_of?(head)
        move("R")
        move("D")
      end
    end
  end

  def right_of?(head)
    x > head.x
  end

  def left_of?(head)
    x < head.x
  end

  def top_of?(head)
    y > head.y
  end

  def down_of?(head)
    y < head.y
  end

  def on_top?(tail)
    x == tail.x && y == tail.y
  end

  def adjacent?(tail)
    (x - 1 == tail.x && y == tail.y) ||
    (x + 1 == tail.x && y == tail.y) ||
    (y - 1 == tail.y && x == tail.x) ||
    (y + 1 == tail.y && x == tail.x)
  end

  def diagonally_touching?(tail)
    (x + 1 == tail.x && y + 1 == tail.y) || (x - 1 == tail.x && y - 1 == tail.y) ||
    (x + 1 == tail.x && y - 1 == tail.y) || (x - 1 == tail.x && y + 1 == tail.y)
  end

  def need_to_move?(head)
    !(on_top?(head) || adjacent?(head) || diagonally_touching?(head))
  end

  def to_s
    "#{x}|#{y}"
  end
end

h = Piece.new
t = Piece.new

visited_by_t = {t.to_s => true}

steps.each do |direction, move_count|
  move_count.times do
    h.move(direction)
  
    if t.need_to_move?(h)
      t.move_towards(h)
      visited_by_t[t.to_s] = true unless visited_by_t.has_key?(t.to_s)
    end
  end
end

p visited_by_t.count
