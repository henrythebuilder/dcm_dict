# coding: utf-8
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

describe "String refinement" do

  describe "should remove unwanted space characters" do
    using DcmDict::StringRefineInternal

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
    using DcmDict::StringRefineInternal

    [
      ['DarkCurrentCounts', :dark_current_counts],
      ['InstanceCreationDate', :instance_creation_date],
      ['RecognitionCode', :recognition_code],
      ['CoefficientsSDVN', :coefficients_sdvn],
      ['OffsetOfReferencedLowerLevelDirectoryEntity', :offset_of_referenced_lower_level_directory_entity],
      ['FileSetDescriptorFileID', :file_set_descriptor_file_id],
      ['SOPClassUID', :sop_class_uid],
      ['RelatedGeneralSOPClassUID', :related_general_sop_class_uid],
      ['ReferencedSOPClassUIDInFile', :referenced_sop_class_uid_in_file],
      ['MAUsedInGainCalibration', :ma_used_in_gain_calibration],
      ['OtherPatientIDsSequence', :other_patient_ids_sequence],
      ['RelativeXRayExposure', :relative_x_ray_exposure],
      ['DisplayedZValue', :displayed_z_value],
      ['PhysicalUnitsXDirection', :physical_units_x_direction],
      ['XRay3DFrameTypeSequence', :x_ray_3d_frame_type_sequence],
      ['SOPInstanceUIDOfConcatenationSource',  :sop_instance_uid_of_concatenation_source],
      ['RowsForNthOrderCoefficients', :rows_for_nth_order_coefficients],
      ['EquivalentCDADocumentSequence', :equivalent_cda_document_sequence],
      ['ALineRate', :a_line_rate],
      ['ThreeDPointCoordinates', :three_d_point_coordinates],
      ['SourceImageIDs', :source_image_ids],
      ['ModifyingDeviceID', :modifying_device_id],
      ['TIDOffset', :tid_offset]
    ].each do |str, value|
      it "from #{str.inspect} to #{value.inspect}" do
        expect(str.tag_key_to_sym).to eq(value)
      end
    end
  end

  describe "should convert standard string tag" do
    using DcmDict::StringRefineInternal

    [
      ['(0014,3050)', '00143050', [0x0014,0x3050]],
      ['(0008,0012)', '00080012', [0x0008,0x0012]],
      ['(FFFE,E00D)', 'FFFEE00D', [0xfffe,0xe00d]]
    ].each do |str, value_str, value_ary|
      it "from #{str.inspect} to a numeric string tag as #{value_str.inspect}" do
        expect(str.to_tag_ndm).to eq(value_str)
      end

      it "from #{str.inspect} to an array object as #{value_ary.inspect}" do
        expect(str.to_tag_ary).to eq(value_ary)
      end
    end
  end

  using DcmDict::StringRefineInternal
  {
    '(0010,0020)'=> [0x0010,0x0020],
    '00100020' => [0x0010,0x0020]

  }.each do |src, expected_val|
    it "should implement to_tag_ary metod" do
      expect(src.to_tag_ary).to eq(expected_val)
    end
  end

  {
    '(0010,0020)'=> '(0010,0020)',
    '00100020' => '(0010,0020)'

  }.each do |src, expected_val|
    it "should implement to_tag_str method" do
      expect(src.to_tag_str).to eq(expected_val)
    end
  end

  [
    '(0010,00208)',
    'abracadabra',
    Time.now.to_s,
  ].each do |src|
    it "should manage wrong value (#{src.inspect}) with to_tag_str method" do
      expect{src.to_tag_str}.to raise_error
    end
  end

end
