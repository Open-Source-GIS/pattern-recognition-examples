#!/usr/bin/env ruby -wKU

require '../common/data.rb'
require '../common/misc.rb'

def forel(points, radius, epsilon)
  clusters = []
  points = points.clone
  while points.length > 0    
    new_center = points.sample
    center = nil
    while (distance(center, new_center) > epsilon)
      center = new_center
      cluster = points.select { |p| distance(center, p) < radius }
      new_center = get_center(cluster)
    end
    clusters << cluster
    points = points - cluster
  end
  clusters
end

if __FILE__ == $PROGRAM_NAME
  input, radius, output = *ARGV
  points = DataIO::read_points(input)
  clusters = forel(points, radius.to_f, 0.01)
  DataIO::write_clusters(output, clusters)
end

