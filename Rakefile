$:.push File.expand_path("../lib", __FILE__)
require "dcm_dict/version"
require 'rake'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

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
