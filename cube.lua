--          - Coordinate System -
--
--        o - - - x         0 - - - 1
--      / |     / |       / |     / |
--    z - + - C   |     4 - + - 5   |
--    |   |   |   |     |   |   |   |
--    |   y - + - C     |   3 - + - 2
--    | /     | /       | /     | /
--    C - - - C         7 - - - 6
--

size = 63 -- 0 inclusive!
points = {}

for k = 0, 1 do
	z = {}
	z[0] = k * size
	for j = 0, 1 do
		y = {}
		y[0] = j * size
		for i = 0, 1 do
			x = {}
			x[0] = ((i + j) % 2) * size
			point = {}
			point[0] = x
			point[1] = y
			point[2] = z
			points[i + (2 * j) + (4 * k)] = point
      -- print(x[0], y[0], z[0])
		end
  end
end

-- m = rotation/projection matrix
-- p is a point {{x}, {y}, {z}}
function mm(m, p)
  matrix = {}
  for i, mr in pairs(m) do
    row = {}
    for j, _ in pairs(p[0]) do -- 0 or k
      sum = 0
      for k, mc in pairs(mr) do 
        -- print(i, j, k, mc, p[k][j])
        sum = sum + mc * p[k][j]
      end
      row[j] = sum
    end
    matrix[i] = row
  end
  return matrix 
end

project2d = {}
project2d[0] = {}
project2d[0][0] = 1
project2d[0][1] = 0
project2d[0][2] = 0
project2d[1] = {}
project2d[1][0] = 0
project2d[1][1] = 1
project2d[1][2] = 0

function apply(matrix, points)
  result = {}
  for i, p in pairs(points) do
    result[i] =  mm(matrix, p)
  end
  return result
end

function rotateX(points, a)
  rotate = {}
  rotate[0] = {}
  rotate[0][0] = 1
  rotate[0][1] = 0
  rotate[0][2] = 0
  rotate[1] = {}
  rotate[1][0] = 0
  rotate[1][1] = math.cos(a)
  rotate[1][2] = -math.sin(a)
  rotate[2] = {}
  rotate[2][0] = 0
  rotate[2][1] = math.sin(a)
  rotate[2][2] = math.cos(a)

  return apply(rotate, points)
end

function rotateY(points, a)
  rotate = {}
  rotate[0] = {}
  rotate[0][0] = math.cos(a)
  rotate[0][1] = 0
  rotate[0][2] = math.sin(a)
  rotate[1] = {}
  rotate[1][0] = 0
  rotate[1][1] = 1
  rotate[1][2] = 0
  rotate[2] = {}
  rotate[2][0] = -math.sin(a)
  rotate[2][1] = 0
  rotate[2][2] = math.cos(a)

  return apply(rotate, points)
end

function rotateZ(points, a)
  rotate = {}
  rotate[0] = {}
  rotate[0][0] = math.cos(a)
  rotate[0][1] = -math.sin(a)
  rotate[0][2] = 0
  rotate[1] = {}
  rotate[1][0] = math.sin(a)
  rotate[1][1] = math.cos(a)
  rotate[1][2] = 0
  rotate[2] = {}
  rotate[2][0] = 0
  rotate[2][1] = 0
  rotate[2][2] = 1

  return apply(rotate, points)
end

function pprint(points)
  for _, p in pairs(apply(project2d,points)) do
    x = p[0][0]
    if x < 0 then x = math.ceil(x) -- otherwise -63.0 becomes -64?!
    else x = math.floor(x) end
    y = p[1][0]
    if y < 0 then y = math.ceil(y)
    else y = math.floor(y) end
    print(x, y, "(", p[0][0], p[1][0], ")")
  end
end

pprint(rotateX(points, math.pi))

