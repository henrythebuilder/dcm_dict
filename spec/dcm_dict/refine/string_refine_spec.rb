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

module DcmDict
  describe "String refinement" do
    using DcmDict::StringRefine
    [
      ["FileSetDescriptorFileID ", "trailing spaces"],
      ["  FileSetDescriptorFileID", "leading spaces"],
      ["  FileSetDescriptorFileID  ", "leading and trailing spaces"],
      ["File​Set​Descriptor​FileID", "zero width spaces"],
      ["  File​Set​Descriptor​FileID  ", "leading, trailing and zero width spaces"]
    ].each do |wrong_string, comment|
      it "should remove unwanted space such as '#{comment}'" do
        expect(wrong_string.dcm_unspace).to eq('FileSetDescriptorFileID')
      end
    end

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
      it "should 'methodize' tag keyword #{str.inspect} as #{value.inspect}" do
        expect(str.dcm_methodize_key).to eq(value)
      end
    end

    [
      ['(0014,3050)', '00143050', [0x0014,0x3050]],
      ['(0008,0012)', '00080012', [0x0008,0x0012]],
      ['(FFFE,E00D)', 'FFFEE00D', [0xfffe,0xe00d]]
    ].each do |str, value_str, value_ary|
      describe "should convert standard tag such as #{str.inspect}"
      it "to numeric string tag as #{value_str.inspect}" do
        expect(str.dcm_tag_to_numeric_string).to eq(value_str)
      end

      it "to array object as #{value_ary.inspect}" do
        expect(str.dcm_tag_to_ary).to eq(value_ary)
      end

    end
  end
end
