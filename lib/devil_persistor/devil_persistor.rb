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
  class DevilPersistor < FilePersistor

    include TempFileMethods

    def persist(image,path,format)

      if path.respond_to? :devil_path
        raise UnableToPersistException
      end

      tmppath = create_temp_path("img") + ".bmp"

      def tmppath.devil_path
      end

      FilePersistor.persist(image,tmppath,:bmp)

      use_temp_file(tmppath) do
        begin
          Devil.with_image(tmppath) do |img|
            img.save(path)
          end
        rescue RuntimeError
          raise UnableToEncodeException
        end
      end

      nil
    end
  end
end
