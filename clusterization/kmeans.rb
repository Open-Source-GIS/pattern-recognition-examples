#!/usr/bin/env ruby -wKU

require "../common/data.rb"
require "../common/misc.rb"

def get_nearest_center(point, centers)
  centers.min_by { |c| distance(point, c) }
end

def clusterize(points, centers)
  (points.group_by { |p| get_nearest_center(p, centers) }).values
end

def nearly?(a, b, epsilon)
  return false if (a == nil or b == nil)
  not (a.zip(b).map { |i| distance(*i) } ).any? { |i| i > epsilon }
end

def kmeans(points, nclusters, epsilon)
  centers = points.sample(nclusters)
  clusters = clusterize(points, centers)
  new_centers = nil
  while not nearly?(centers, new_centers, epsilon)
    centers = new_centers
    new_centers = clusters.map { |p| get_center(p) }
    clusters = clusterize(points, new_centers)
  end
  clusters
end

if __FILE__ == $PROGRAM_NAME
  input =  ARGV.shift
  n =      ARGV.shift
  output = ARGV.shift
  points = DataIO::read_points(input)
  clusters = kmeans(points, n.to_i, 0.01)
  DataIO::write_clusters(output, clusters)
end
