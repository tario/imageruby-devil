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

require "helper/tempfile"
require "imageruby/decoder"

module ImageRuby
  class DevilDecoder < ImageRuby::Decoder

    include TempFileMethods

    def decode(data, image_class)

      magic = data[0..1]

      # devil decoder cannot read bmp files because use bmp decoder
      if magic == "BM" then
        raise UnableToDecodeException
      end

      # creates a temp file with data
      create_temp_file("img", data) do |tmpfile|
        path2 = create_temp_path("img2") + ".bmp"
        path = tmpfile.path

        use_temp_file(path2) do
          Devil.with_image(path) do |img|
            img.save(path2)
          end

          encoded_bmp = nil

          File.open(path2, "rb") do |file|
            encoded_bmp = file.read
          end

          ImageRuby::Decoder.decode(encoded_bmp, image_class)
        end
      end
    end
  end
end