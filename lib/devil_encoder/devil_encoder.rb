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

require "imageruby/encoder"

module ImageRuby
  class DevilEncoder < ImageRuby::Encoder

    def encode(image, format, output)
      if format == :bmp
        raise UnableToEncodeException
      end

      tmpfile = Tempfile.new("img")
      tmppath = tmpfile.path + ".bmp"
      tmpfile.close

      # save image data in a temp file
      image.save(tmppath, :bmp)

      tmpfile2 = Tempfile.new("img2")
      tmppath2 = tmpfile2.path + "." + format.to_s
      tmpfile2.close

      Devil.with_image(tmppath) do |img|
        img.save(tmppath2)
      end

      File.open(tmppath2) do |file|
        file.read
      end

    end
  end
end