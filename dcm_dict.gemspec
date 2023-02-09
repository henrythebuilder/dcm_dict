$:.push File.expand_path("../lib", __FILE__)
require "dcm_dict/version"

Gem::Specification.new do |s|
  s.name          = 'dcm_dict'
  s.version       = DcmDict::VERSION
  s.platform      = Gem::Platform::RUBY
  s.date          = TODAY
  s.summary       = "A simple way to handle DICOM Data Dictionary"
  s.description   = "DcmDict is a Ruby gem (dcm_dict) to handle in a simple way the Data Dictionary defined within the DICOM Standard"
  s.authors       = ["Enrico Rivarola"]
  s.email         = 'henrythebuilder@yahoo.it'
  s.files         = Dir.glob("lib/**/*")
  s.files         += %w[README.md LICENSE COPYING CHANGELOG.md]
  s.test_files    = Dir.glob("spec/**/*")
  s.test_files    += %w[Rakefile]
  s.require_paths = ['lib']
  s.executables   << 'dcm_dict_converter.rb'
  s.homepage      = 'http://rubygems.org/gems/dcm_dict'
  s.license       = 'GPL-3.0+'
  s.required_ruby_version = '>= 3.0'
  s.add_development_dependency('nokogiri',  '~> 1.14',   '>= 1.14.0')
  s.add_development_dependency('rspec',     '~> 3.12',   '>= 3.12.0')
  s.add_development_dependency('simplecov', '~> 0.22',   '>= 0.22.0')
  s.add_development_dependency('rake',      '~> 13.0',   '>= 13.0.0')
  s.metadata = {
  "bug_tracker_uri"   => "https://github.com/henrythebuilder/dcm_dict/issues",
  "changelog_uri"     => "https://github.com/henrythebuilder/dcm_dict/blob/master/CHANGELOG.md",
  "documentation_uri" => "http://www.rubydoc.info/gems/dcm_dict/" + DcmDict::VERSION.to_s,
  "homepage_uri"      => "http://rubygems.org/gems/dcm_dict",
#  "mailing_list_uri"  => "",
  "source_code_uri"   => "https://github.com/henrythebuilder/dcm_dict",
#  "wiki_uri"          => ""
}
end
