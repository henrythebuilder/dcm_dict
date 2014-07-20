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
require 'spec_helper'
require 'xml_sample_spec_helper'

describe DcmDict::DataToCode do
  describe "should print out" do
    it "data elements header code" do
      header = DcmDict::DataToCode.data_element_header
      expected_header = <<END
module DcmDict
  module SourceData
    DataElementsData = [
END
      expect(header).to eq(expected_header)
    end

    it "data elements footer code" do
      footer = DcmDict::DataToCode.data_element_footer
      expected_footer=<<END
    ]
  end
end
END
      expect(footer).to eq(expected_footer)
    end

  end

  describe "should covert data element data to source code text" do
    it "for standard sample" do
      sample = XmlSampleSpecHelper.xml_sample_standard.flatten
      xml_string, data = sample
      ns = XmlSampleSpecHelper.string_to_nodeset(xml_string)
      xml_data = DcmDict::XML::NodeSetData.new(ns).data_element_data
      indent = 4
      src_text = "#{' '*indent}{ tag_ps: '#{data[:tag_ps]}', tag_name: \"#{data[:tag_name]}\", tag_key: '#{data[:tag_key]}', tag_vr: #{data[:tag_vr]}, tag_vm: #{data[:tag_vm]}, tag_str: '#{data[:tag_str]}', tag_sym: #{data[:tag_sym].inspect}, tag_ndm: '#{data[:tag_ndm]}', tag_ary: #{data[:tag_ary].inspect}, tag_multiple: #{data[:tag_multiple].inspect}, tag_note: '#{data[:tag_note]}'},"
      src_line = DcmDict::DataToCode.data_element_data_to_code(xml_data)
      expect(src_line).to eq(src_text)
      src_line = DcmDict::DataToCode.data_element_data_to_code(xml_data, indent: indent)
      expect(src_line).to eq(src_text)
      indent = 6
      src_line = DcmDict::DataToCode.data_element_data_to_code(xml_data, indent: indent)
      expect(src_line.start_with?("#{' '*indent}{")).to be true
    end
  end
end
