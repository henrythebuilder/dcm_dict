$:.push File.expand_path("../lib", __FILE__)
require "dcm_dict/version"
require 'rake'
require 'rspec/core/rake_task'

desc "Check all spec"
RSpec::Core::RakeTask.new(:spec) do |t|
  t.pattern = 'spec/**/*_spec.rb'
  t.ruby_opts = "-w"
  t.rspec_opts = '--color --format documentation'
end

desc "Check all spec with code coverage"
task :coverage do
  ENV['COVERAGE'] = "true"
  Rake::Task["spec"].execute
end

desc(task(:coverage).comment)
task :default => :coverage

desc "Build dcm_dict v#{DcmDict::VERSION} gem"
task :build do
  system "gem build dcm_dict.gemspec"
  FileUtils.mkdir_p "pkg"
  FileUtils.mv "dcm_dict-#{DcmDict::VERSION}.gem", "pkg"
end

desc "Open IRB with DcmDict support"
task :console do
  require 'irb'
  require 'irb/completion'
  require 'dcm_dict'
  ARGV.clear
  IRB.start
end
