def distance(a, b)
  return Float::INFINITY if (a == nil or b == nil)
  Math::sqrt((a.zip(b).map { |pair| (pair.last - pair.first) ** 2 }).inject(:+))
end

def get_center(points)
  points.transpose.map { |i| i.inject(:+) / points.length }
end
