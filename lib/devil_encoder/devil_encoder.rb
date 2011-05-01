=begin

This file is part of the imageruby-devil project, http://github.com/tario/imageruby-devil

Copyright (c) 2010 Roberto Dario Seminara <robertodarioseminara@gmail.com>

imageruby-devil is free software: you can redistribute it and/or modify
it under the terms of the gnu general public license as published by
the free software foundation, either version 3 of the license, or
(at your option) any later version.

imageruby-devil is distributed in the hope that it will be useful,
but without any warranty; without even the implied warranty of
merchantability or fitness for a particular purpose.  see the
gnu general public license for more details.

you should have received a copy of the gnu general public license
along with imageruby-devil.  if not, see <http://www.gnu.org/licenses/>.

=end
require "devil"
require "tempfile"

require "imageruby/decoder"

module ImageRuby
  class DevilDecoder < ImageRuby::Decoder
    def decode(data, image_class)
      # creates a temp file with data
      tmpfile = Tempfile.new("img")
      tmpfile.write data

      path = tmpfile.path

      tmpfile.close

      tmpfile2 = Tempfile.new("img2")

      path2 = tmpfile2.path + ".bmp"
      tmpfile2.close

      Devil.with_image(path) do |img|
        img.save(path2)
      end

      image_class.from_file(path2)
    end
  end
end