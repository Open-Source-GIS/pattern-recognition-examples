#!/usr/bin/env ruby -wKU

require "csv"

def generate(length, n)
  points = []
  n.times do
    point = []
    length.times { point << rand(100) }
    points << point
  end
  points
end

if __FILE__ == $PROGRAM_NAME
  length, n, output = *ARGV
  points = generate(length.to_i, n.to_i)
  CSV.open(output, "wb") do |csv|
    points.each do |p|
      csv << p
    end
  end
end
