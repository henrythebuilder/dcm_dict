$:.push File.expand_path("../lib", __FILE__)
require "dcm_dict/version"
require 'rake'
require 'rspec/core/rake_task'

desc "Run RSpec for all spec"
RSpec::Core::RakeTask.new(:spec) do |t|
  t.pattern = 'spec/**/*_spec.rb'
  t.ruby_opts = "-w"
  t.rspec_opts = '--format documentation'
end

desc "Run RSpec with code coverage"
task :coverage do
  ENV['COVERAGE'] = "true"
  Rake::Task["spec"].execute
end

desc "Run tests with code coverage"
task :default => :coverage

desc "Build dcm_dict v#{DcmDict::VERSION} gem"
task :build do
  system "gem build dcm_dict.gemspec"
  FileUtils.mkdir_p "pkg"
  FileUtils.mv "dcm_dict-#{DcmDict::VERSION}.gem", "pkg"
end

# task :console do
#   require 'irb'
#   require 'irb/completion'
#   require 'dcm_dict'
#   ARGV.clear
#   IRB.start
# end
