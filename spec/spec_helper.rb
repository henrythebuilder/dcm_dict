#
#  Copyright (C) 2014-2018  Enrico Rivarola
#
#  This file is part of DcmDict gem (dcm_dict).
#
#  DcmDict is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 3 of the License, or
#  (at your option) any later version.
#
#  DcmDict is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with DcmDict.  If not, see <http://www.gnu.org/licenses/>.
#
#  This software has neither been tested nor approved for clinical use
#  or for incorporation in a medical device.
#  It is the redistributor's or user's responsibility to comply with any
#  applicable local, state, national or international regulations.
#
if ENV['COVERAGE']
  begin
    require 'simplecov'
    SimpleCov.start
  rescue LoadError
  end
end

if (RUBY_ENGINE == 'rbx')
  require 'dcm_dict/rubies/rb_ext'
end

require 'dcm_dict'
require 'dcm_dict/xml/nokogiri_tool'
require 'dictionary_shared_example_spec_helper'
require 'data_element_shared_example_spec_helper'
require 'refine_shared_example_spec_helper'
require 'dcm_dict/xml/rexml_tool'
require 'dcm_dict/xml/xml_tool'
