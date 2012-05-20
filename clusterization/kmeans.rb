#!/usr/bin/env ruby -wKU

require 'csv'

def distance(a, b)
  Math::sqrt((a.zip(b).map { |pair| (pair.last - pair.first) ** 2 }).inject(:+))
end

def get_center(points)
  points.transpose.map { |i| i.inject(:+) / points.length }
end

def get_nearest_center(point, centers)
  centers.min_by { |c| distance(point, c) }
end

def arrange(points, centers)
  (points.group_by { |p| get_nearest_center(p, centers) }).values
end

def nearly?(a, b, epsilon)
  return false if (a == nil or b == nil)
  not (a.zip(b).map { |i| distance(*i) } ).any? { |i| i > epsilon }
end

def kmeans(points, nclusters, epsilon)
  centers = points.sample(nclusters)
  clusters = arrange(points, centers)
  new_centers = nil
  while not nearly?(centers, new_centers, epsilon)
    centers = new_centers
    new_centers = clusters.map { |p| get_center(p) }
    clusters = arrange(points, new_centers)
  end
  clusters
end

if __FILE__ == $PROGRAM_NAME
  input, n, output = *ARGV
  points = CSV.read(input).map { |row| row.map { |i| i.to_f }}
  clusters = kmeans(points, n.to_i, 0.01)
  CSV.open(output, "wb") do |csv|
    clusters.each do |cluster|
      csv << ["-"]
      cluster.each do |p|
        csv << p
      end
    end
  end
end
