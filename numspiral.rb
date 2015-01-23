require 'rubygems'
require 'rmagick'
require 'prime'

width = ARGV[0].to_i
height = ARGV[1].to_i

img = Magick::Image.new(width, height)
x = width/2-1
y = height/2-1

lensize = 1
leniter = 2
timesatlen = 1

turn = {"l" => "d", "d" => "r", "u" => "l", "r" => "u"}
i = 1 
dir = "r"

class Fixnum
  def prime?
    return false if self % 2 == 0
    max = Math.sqrt(self).floor

    $cache.each do |i|
      return true if i > max 
      return false if self % i == 0  
    end
  end
end

print "Generating prime cache: "
$cache = Prime.first Math.sqrt( width * height ).floor
print "DONE\n"

print "Creating picture: "
while true
  break if x > width or x < 0
  break if y > height or y < 0

  if i.prime? 
    img.pixel_color(x, y, "rgb(0,0,0)")
  end

  i += 1
  leniter -= 1

  # Move
	case dir
	when "r"
		x += 1
	when "l"
		x -= 1
	when "u"
		y += 1
	when "d"
		y -= 1
	end

  # Direction handling
  if leniter == 0
		dir = turn[dir]

    # Resetting and moving again properly
    leniter = lensize
    timesatlen -= 1
    if timesatlen == 0
      lensize += 1
      timesatlen = 2
    end
  end
end

print "DONE\n"

print "Writing image: "
img.write("demo-#{width}x#{height}.bmp")
print "DONE\n"
