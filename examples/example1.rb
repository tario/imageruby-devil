require "rubygems"
require "imageruby"

include ImageRuby

# create image (red gradient and random green)
image = Image.new(255,255) {|x,y| Color.from_rgb(x,rand(200),0) }

# save image on png format
image.save("image.png", :png)
