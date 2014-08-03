#
#  Copyright (C) 2014  Enrico Rivarola
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
require 'spec_helper'
require 'xml_sample_spec_helper'

describe "XML management for UID" do
  describe "should extract data from single node set data (with nokogiri gem)" do
    XmlSampleSpecHelper.xml_uid_set.each do |xml_string, expected_data|
      ns = XmlSampleSpecHelper.string_to_nokogiri_nodeset(xml_string)
      noko_proc = DcmDict::XML::NokogiriTool.uid_field_extract_proc(ns)
      xml_data = DcmDict::XML::UidFieldData.new(noko_proc).uid_data
      describe "for '#{expected_data[:uid_name]}'" do
        expected_data.each do |key, expected_value|
          it "with key #{key.inspect}" do
            expect(xml_data[key]).to eq(expected_value)
          end
        end
      end
    end
  end

  describe "should extract data from single node set data (with REXML)" do
    XmlSampleSpecHelper.xml_uid_set.each do |xml_string, expected_data|
      ns = XmlSampleSpecHelper.string_to_rexml_nodeset(xml_string)
      proc = DcmDict::XML::RexmlTool.uid_field_extract_proc(ns)
      xml_data = DcmDict::XML::UidFieldData.new(proc).uid_data
      describe "for '#{expected_data[:uid_name]}'" do
        expected_data.each do |key, expected_value|
          it "with key #{key.inspect}" do
            expect(xml_data[key]).to eq(expected_value)
          end
        end
      end
    end
  end

end
