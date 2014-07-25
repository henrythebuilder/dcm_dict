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

describe DcmDict::Dictionary::UidRecord do
  [
    { uid_value: '1.2.840.10008.1.2',
      uid_name: "Implicit VR Little Endian: Default Transfer Syntax for DICOM",
      uid_type: :transfer_syntax }
  ].each do |data|
    it "Handle Data Element Data correctly" do
      ur = DcmDict::Dictionary::UidRecord.new(data)
      expect(ur.uid_value).to eq(data[:uid_value])
      expect(ur.uid_name).to eq(data[:uid_name])
      expect(ur.uid_type).to eq(data[:uid_type])
    end


    it "Handle methods correctly (by symbol)" do
      ur = DcmDict::Dictionary::UidRecord.new(data)
      data.each do |key, expected_val|
        expect(ur.respond_to?(key)).to be true
      end

      expect(ur.respond_to?(:undefined_method_for_data_element_record)).to be false
      expect {ur.undefined_method_for_data_element_record }.to raise_error(NoMethodError)
    end

    it "Handle methods correctly (by string)" do
      ur = DcmDict::Dictionary::DataElementRecord.new(data)
      data.each do |key, expected_val|
        expect(ur.respond_to?(key.to_s)).to be true
      end

      expect(ur.respond_to?(:undefined_method_for_uid_record.to_s)).to be false
      expect {ur.undefined_method_for_data_element_record }.to raise_error(NoMethodError)
      expect {ur.send("undefined_method_for_uid_record") }.to raise_error(NoMethodError)
    end
  end
end
