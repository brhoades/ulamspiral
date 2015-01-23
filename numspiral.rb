require 'rubygems'
require 'rmagick'
require 'prime'

width = 2048
height = 2048
img = Magick::Image.new(width, height)
x = width/2-1
y = height/2-1

lensize = 1
leniter = 2
timesatlen = 1
dir = "r"
i = 1 

while true
  break if x > width or x < 0
  break if y > height or y < 0
  if Prime.prime? i 
    img.pixel_color(x, y, "rgb(0,0,0)")
  end
  #print "#{i}\t"
  i += 1

  # Move
  leniter -= 1
  x += 1 if dir == "r" 
  x -= 1 if dir == "l"
  y += 1 if dir == "u"
  y -= 1 if dir == "d"

  # Direction handling
  if leniter == 0
    #print "^\n"
    if dir == "l"
      dir = "d"
    elsif dir == "d"
      dir = "r"
    elsif dir == "u"
      dir = "l"
    elsif dir == "r"
      dir = "u"
    end

    # Resetting and moving again properly
    leniter = lensize
    timesatlen -= 1
    if timesatlen == 0
      lensize += 1
      timesatlen = 2
    end
  end
  
  
end

img.write("demo-#{width}x#{height}.bmp")
