
module DataIO
  def self.write_set(file, points)
      points.each do |p|
        file.puts "\t" + p.join("\t")
      end
  end

  def self.write_points(filename, points)
    File.open(filename, "w") do |f|
      write_set(f, points)
    end
  end

  def self.read_points(filename)
    points = []
    File.open(filename, "r") do |f|
      f.each do |line|
        points << line.strip.split("\t").map { |i| i.to_f }
      end
    end
    points
  end

  def self.get_hex_number
    num = rand(256).to_s(16)
    num = "0" + num if (num.length == 1)
    num
  end

  def self.get_color
    "\##{get_hex_number}#{get_hex_number}#{get_hex_number}"
  end

  def self.write_clusters(filename, clusters)              
    File.open(filename, "w") do |f|
      f.puts "set multiplot"
      f.puts "set xrange [0:100]"
      f.puts "set yrange [0:100]"
      clusters.each do |points|
        f.puts "plot '-' linecolor rgb \"#{get_color}\""
        write_set(f, points)
        f.puts "end"
      end
      f.puts "unset multiplot"
    end    
  end
end
