require "rubygems"
require "imageruby"

include ImageRuby

# load image generated in the previous example
image = Image.from_file("image.png")

# apply blur effect
image = image.blur(10)

# mirror image
image = image.mirror

# save image on png format
image.save("image2.png", :png)
