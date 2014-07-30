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


    include_examples "Record handle methods correctly",
                     DcmDict::Dictionary::UidRecord.new(data),
                     data

  end
end
