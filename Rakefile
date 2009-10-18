require 'rubygems'
require 'rake'
require 'rake/testtask'

desc 'Default: run tests.'
task :default => :test

begin
  require 'jeweler'
  Jeweler::Tasks.new do |s|
    s.name = 'ruby-odrl'
    s.summary = 'An Open Digital Rights Language Policy Determination Point library'
    s.email = 'chris@authoritativeopinion.com'
    s.authors = ["chris beer"]
    s.files = FileList["[A-Z]*", "{lib,test}/**/*.rb"]
  end
rescue LoadError
   puts "Jeweler not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
end

Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/*_test.rb'
  test.verbose = false
end
