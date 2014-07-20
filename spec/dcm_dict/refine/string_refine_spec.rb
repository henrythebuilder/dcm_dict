# coding: utf-8

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

describe "String refinement" do

  describe "should remove unwanted space characters" do
    using DcmDict::StringRefineXml

    [
      ["FileSetDescriptorFileID ", "trailing spaces"],
      ["  FileSetDescriptorFileID", "leading spaces"],
      ["  FileSetDescriptorFileID  ", "leading and trailing spaces"],
      ["File​Set​Descriptor​FileID", "zero width spaces"],
      ["  File​Set​Descriptor​FileID  ", "leading, trailing and zero width spaces"]
    ].each do |wrong_string, comment|
      it "for string containing #{comment}" do
        expect(wrong_string.dcm_unspace).to eq('FileSetDescriptorFileID')
      end
    end
  end

  describe "should convert keyword tag string to symbol object" do
    using DcmDict::StringRefineXml

    [
      ['DarkCurrentCounts', :dark_current_counts],
      ['InstanceCreationDate', :instance_creation_date],
      ['RecognitionCode', :recognition_code],
      ['CoefficientsSDVN', :coefficients_sdvn],
      ['OffsetOfReferencedLowerLevelDirectoryEntity', :offset_of_referenced_lower_level_directory_entity],
      ['FileSetDescriptorFileID', :file_set_descriptor_file_id],
      ['SOPClassUID', :sop_class_uid],
      ['RelatedGeneralSOPClassUID', :related_general_sop_class_uid]
    ].each do |str, value|
      it "from #{str.inspect} to #{value.inspect}" do
        expect(str.tag_key_to_sym).to eq(value)
      end
    end
  end

  describe "should convert standard string tag" do
    using DcmDict::StringRefineXml

    [
      ['(0014,3050)', '00143050', [0x0014,0x3050]],
      ['(0008,0012)', '00080012', [0x0008,0x0012]],
      ['(FFFE,E00D)', 'FFFEE00D', [0xfffe,0xe00d]]
    ].each do |str, value_str, value_ary|
      it "from #{str.inspect} to a numeric string tag as #{value_str.inspect}" do
        expect(str.tag_str_to_digit_str).to eq(value_str)
      end

      it "from #{str.inspect} to an array object as #{value_ary.inspect}" do
        expect(str.tag_str_to_ary).to eq(value_ary)
      end
    end
  end

end
