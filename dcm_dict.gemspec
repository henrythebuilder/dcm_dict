$:.push File.expand_path("../lib", __FILE__)
require "dcm_dict/version"

Gem::Specification.new do |s|
  s.name        = 'dcm_dict'
  s.version     = DcmDict::VERSION
  s.date        = DateTime.now.strftime('%Y-%m-%d')
  s.summary     = "A simple way to handle DICOM Data Dictionary"
  s.description = "DcmDict is a Ruby gem (dcm_dict) to handle in a simple way the Data defined within the DICOM Standard"
  s.authors     = ["Enrico Rivarola"]
  s.email       = 'henrythebuilder@yahoo.it'
  s.files       = `git ls-files`.split("\n")
  s.homepage    = 'http://rubygems.org/gems/dcm_dict'
  s.license     = 'GPL-3.0+'
  s.required_ruby_version = '>= 2.1'
end
