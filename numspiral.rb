require 'rubygems'
require 'rmagick'
require 'prime'
require 'ruby-prof'

# Profile the code
RubyProf.start

width = ARGV[0].to_i
height = ARGV[1].to_i
img = Magick::Image.new(width, height)
x = width/2-1
y = height/2-1

lensize = 1
leniter = 2
timesatlen = 1
dir = "r"
i = 1 

turn = {"l" => "d", "d" => "r", "u" => "l", "r" => "u"}

while true
  break if x > width or x < 0
  break if y > height or y < 0

  if i % 2 and Prime.prime? i 
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

img.write("demo-#{width}x#{height}.bmp")

res = RubyProf.stop

File.open "profiling/profile_#{Time.now}", 'w' do |file|
  printer = RubyProf::CallTreePrinter.new( res ).print( file )
end
