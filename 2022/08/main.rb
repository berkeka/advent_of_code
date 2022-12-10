INPUT_FILE_NAME = File.join(File.dirname(__FILE__), 'input.txt')
input = File.read(INPUT_FILE_NAME)

grid = input.split("\n")

$x = grid[0].length
$y = grid.length

edges_count = 2 * $x + (2 * $y) - 4

grid.map!{|x| x.chars.map!(&:to_i)}

def visible_up?(grid, height_of_tree, i, j)
  visible = false
  score = 0
  for index_y in (i - 1).downto(0)
    if grid[index_y][j] < height_of_tree
      score += 1
      visible = true
    else  
      return false, score + 1
    end
  end

  return visible, score
end

def visible_down?(grid, height_of_tree, i, j)
  visible = false
  score = 0
  for index_y in (i + 1...$y)
    if grid[index_y][j] < height_of_tree
      score += 1
      visible = true
    else  
      return false, score + 1
    end
  end

  return visible, score
end

def visible_right?(grid, height_of_tree, i, j)
  visible = false
  score = 0
  for index_x in (j + 1...$x)
    if grid[i][index_x] < height_of_tree
      score += 1
      visible = true
    else
      return false, score + 1
    end 
  end

  return visible, score
end

def visible_left?(grid, height_of_tree, i, j)
  visible = false
  score = 0
  for index_x in (j - 1).downto(0)
    if grid[i][index_x] < height_of_tree
      score += 1
      visible = true
    else
      return false, score + 1
    end
  end

  return visible, score
end

def visible?(grid, i, j)
  height_of_tree = grid[i][j]

  up_visible, up_score = visible_up?(grid, height_of_tree, i, j)
  down_visible, down_score = visible_down?(grid, height_of_tree, i, j)
  left_visible, left_score = visible_left?(grid, height_of_tree, i, j)
  right_visible, right_score = visible_right?(grid, height_of_tree, i, j)

  return (up_visible || down_visible || left_visible || right_visible), (up_score * down_score * left_score * right_score)
end

visible_tree_count = edges_count
max_scenic_score = 0

for i in (1...grid.length - 1)
  for j in (1...grid[i].length - 1)
    visible, scenic_score = visible?(grid, i, j)
    visible_tree_count += 1 if visible
    max_scenic_score = scenic_score if scenic_score > max_scenic_score
  end
end

p visible_tree_count
p max_scenic_score
