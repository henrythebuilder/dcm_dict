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
require 'spec_helper'
require 'xml_sample_spec_helper'

describe DcmDict::Encoder::DataToCode do
  describe "should print out data element with" do
    it "data elements header code" do
      header = DcmDict::Encoder::DataToCode.data_element_header
      expected_header = <<END
module DcmDict
  module SourceData
    DataElementsData = [
END
      expect(header).to eq(expected_header)
    end

    it "data elements footer code" do
      footer = DcmDict::Encoder::DataToCode.data_element_footer
      expected_footer=<<END
    ]
  end
end
END
      expect(footer).to eq(expected_footer)
    end

    describe "data element data field" do
      using DcmDict::Refine::Internal::ArrayRefineInternal

      XmlSampleSpecHelper.xml_tag_single_set.each do |xml_string, data|
        it "for data element sample as #{data[:tag_ps].inspect}" do
          indent = 4
          tag_ary_str = "[0x#{data[:tag_ary].tag_group_str},0x#{data[:tag_ary].tag_element_str}]"
          src_text = "#{' '*indent}{ tag_ps: '#{data[:tag_ps]}', tag_name: \"#{data[:tag_name]}\", tag_key: '#{data[:tag_key]}', tag_vr: #{data[:tag_vr]}, tag_vm: #{data[:tag_vm]}, tag_str: '#{data[:tag_str]}', tag_sym: #{data[:tag_sym].inspect}, tag_ndm: '#{data[:tag_ndm]}', tag_ary: #{tag_ary_str}, tag_multiple: #{data[:tag_multiple].inspect}, tag_note: '#{data[:tag_note]}'},"
          src_line = DcmDict::Encoder::DataToCode.data_element_data_to_code(data)
          expect(src_line).to eq(src_text)
          src_line = DcmDict::Encoder::DataToCode.data_element_data_to_code(data, indent)
          expect(src_line).to eq(src_text)
          indent = 6
          src_line = DcmDict::Encoder::DataToCode.data_element_data_to_code(data, indent)
          expect(src_line.start_with?("#{' '*indent}{")).to be true
        end
      end

    end
  end

   describe "should print out uid with" do
    it "uid header code" do
      header = DcmDict::Encoder::DataToCode.uid_header
      expected_header = <<END
module DcmDict
  module SourceData
    UidValuesData = [
END
      expect(header).to eq(expected_header)
    end

    it "uid footer code" do
      footer = DcmDict::Encoder::DataToCode.uid_footer
      expected_footer=<<END
    ]
  end
end
END
      expect(footer).to eq(expected_footer)
    end

    describe "uid data field" do
      XmlSampleSpecHelper.xml_uid_set.each do |xml_string, data|
      it "for uid sample as #{data[:uid_value].inspect}" do
        indent = 4
        src_text = "#{' '*indent}{ uid_value: '#{data[:uid_value]}', uid_name: \"#{data[:uid_name]}\", uid_type: #{data[:uid_type].inspect}},"
        src_line = DcmDict::Encoder::DataToCode.uid_data_to_code(data)
        expect(src_line).to eq(src_text)
        src_line = DcmDict::Encoder::DataToCode.uid_data_to_code(data, indent)
        expect(src_line).to eq(src_text)
        indent = 6
        src_line = DcmDict::Encoder::DataToCode.uid_data_to_code(data, indent)
        expect(src_line.start_with?("#{' '*indent}{")).to be true
      end
      end
    end

  end

end
