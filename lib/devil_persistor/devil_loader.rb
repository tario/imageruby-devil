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
require "imageruby"

module ImageRuby
  class DevilFileLoader < ImageRuby::FileLoader

    include TempFileMethods

    def load(path)

      if path.respond_to? :devil_path
        raise UnableToLoadException
      end

      path2 = create_temp_path("img2") + ".bmp"

      def path2.devil_path

      end

      use_temp_file(path2) do
        Devil.with_image(path) do |img|
          img.save(path2)
        end

        ImageRuby::FileLoader.load(path2)
      end
    end
  end
end