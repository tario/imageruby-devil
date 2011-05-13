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
require "tempfile"

module TempFileMethods

  def create_temp_file(basename, data)
    tmpfile = Tempfile.new(basename)
    ret = nil
    begin
      tmpfile.write data
      tmpfile.close
      ret = yield(tmpfile)
    ensure
      tmpfile.delete
    end

    ret
  end

  def use_temp_file(path)
    begin
      yield
    ensure
      File.delete(path)
    end
  end

  def create_temp_path(basename)
      tmpfile = Tempfile.new(basename)
      tmppath = tmpfile.path
      tmpfile.close
      tmpfile.delete
      tmppath
  end
end
