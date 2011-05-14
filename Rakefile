require 'rubygems'
require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'
require 'rake/gempackagetask'

spec = Gem::Specification.new do |s|
  s.name = 'imageruby-devil'
  s.version = '0.1.0'
  s.author = 'Dario Seminara'
  s.email = 'robertodarioseminara@gmail.com'
  s.platform = Gem::Platform::RUBY
  s.summary = 'Bridge between ImageRuby and Devil image library'
  s.homepage = "http://github.com/tario/imageruby-devil"
  s.has_rdoc = true
  s.extra_rdoc_files = [ 'README' ]
  s.add_dependency "devil", ">= 0.1.9.5"
#  s.rdoc_options << '--main' << 'README'
  s.files = Dir.glob("{lib}/**/*") + Dir.glob("{examples}/**/*.rb") 
    [ 'LICENSE', 'AUTHORS', 'CHANGELOG', 'README', 'Rakefile' ]
end

desc 'Run tests'
task :default => [ :test ]

Rake::TestTask.new('test') do |t|
  t.libs << 'test'
  t.pattern = '{test}/**/test_*.rb'
  t.verbose = true
end

desc 'Generate RDoc'
Rake::RDocTask.new :rdoc do |rd|
  rd.rdoc_dir = 'doc'
  rd.rdoc_files.add 'lib', 'README'
  rd.main = 'README'
end

desc 'Build Gem'
Rake::GemPackageTask.new spec do |pkg|
  pkg.need_tar = true
end

desc 'Clean up'
task :clean => [ :clobber_rdoc, :clobber_package ]

desc 'Clean up'
task :clobber => [ :clean ]
