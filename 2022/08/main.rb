INPUT_FILE_NAME = File.join(File.dirname(__FILE__), 'input.txt')
input = File.read(INPUT_FILE_NAME)

grid = input.split("\n")

$x = grid[0].length
$y = grid.length

edges_count = 2 * $x + (2 * $y) - 4

grid.map!{|x| x.chars.map!(&:to_i)}

def visible_up?(grid, height_of_tree, i, j)
  visible = false
  for index_y in (0...i)
    if grid[index_y][j] < height_of_tree
      visible = true
    else  
      return false
    end
  end

  return visible
end

def visible_down?(grid, height_of_tree, i, j)
  visible = false
  for index_y in (i + 1...$y)
    if grid[index_y][j] < height_of_tree
      visible = true
    else  
      return false
    end
  end

  return visible
end

def visible_left?(grid, height_of_tree, i, j)
  visible = false
  for index_x in (j + 1...$x)
    if grid[i][index_x] < height_of_tree
      visible = true
    else
      return false
    end 
  end

  return visible
end

def visible_right?(grid, height_of_tree, i, j)
  visible = false
  for index_x in (0...j)
    if grid[i][index_x] < height_of_tree
      visible = true
    else
      return false
    end
  end

  return visible
end

def visible?(grid, i, j)
  height_of_tree = grid[i][j]

  return visible_up?(grid, height_of_tree, i, j) || 
    visible_down?(grid, height_of_tree, i, j) || 
    visible_left?(grid, height_of_tree, i, j) || 
    visible_right?(grid, height_of_tree, i, j)
end

visible_tree_count = edges_count

for i in (1...grid.length - 1)
  for j in (1...grid[i].length - 1)
    visible_tree_count += 1 if visible?(grid, i, j)
  end
end

p visible_tree_count
