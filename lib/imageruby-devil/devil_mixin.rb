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
require "helper/tempfile"

module ImageRuby

  module ImageRubyDevilMixin

      class << self
        include TempFileMethods
      end
      include TempFileMethods

      def self.tmppath
        tmpfile = Tempfile.new("img")
        path = tmpfile.path
        tmpfile.close

        path
      end

      def self.from_devil(devil_image)
        path = ImageRubyDevilMixin.tmppath+".bmp"

        use_temp_file(path) do
          devil_image.save(path)
          Image.from_file(path)
        end
      end

      def to_devil
        path = ImageRubyDevilMixin.tmppath+".bmp"
        save(path,:bmp)

        use_temp_file(path) do
          if block_given?
            Devil.with_image(path) do |devil_image|
              yield(devil_image)
            end
          else
            Devil.load_image(path)
          end
        end
      end

      def devil

        img = nil

        self.to_devil do |devil_image|
          yield(devil_image)
          img = ImageRubyDevilMixin.from_devil(devil_image)
        end

        img
      end

    # devil methods
    ["alienify", "blur", "contrast", "edge_detect", "enboss", "equalize", "flip",
    "gamma_correct", "mirror", "negate", "nosify", "rotate", "sharpen", "to_blob"].each do |m|
      define_method m do |*args|
        devil do |devil_image|
          devil_image.send(m,*args)
        end
      end
    end
  end

  register_image_mixin ImageRubyDevilMixin

end
