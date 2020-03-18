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

describe DcmDict::Dictionary::UidDictionary do

  include_examples "Map all source data",
                   [:uid_value, :uid_name],
                   DcmDict::SourceData::UidValuesData,
                   DcmDict::Dictionary::TheUidDictionary,
                   DcmDict::Dictionary::UidRecord,
                   [:uid_value, :uid_name, :uid_type]

  {
    '1.2.3.4.5.6'                   => { :uid_value => '1.2.3.4.5.6',
                                         :uid_name  => 'Unknown UID',
                                         :uid_type  => :unknown },
    '1.2.840.10008.5.1.4.1.1.12.77' => { :uid_value => '1.2.840.10008.5.1.4.1.1.12.77',
                                         :uid_name  => '1.2.840.10008.5.1.4.1.1.12.77 (Retired)',
                                         :uid_type  => :sop_class },
    '1.2.840.10008.5.1.4.1.1.40'    => { :uid_value => '1.2.840.10008.5.1.4.1.1.40',
                                         :uid_name  => '1.2.840.10008.5.1.4.1.1.40 (Retired)',
                                         :uid_type  => :sop_class },
    '1.2.840.10008.5.1.4.39.3'      => { :uid_value => '1.2.840.10008.5.1.4.39.3',
                                         :uid_name  => 'Color Palette Query/Retrieve Information Model - MOVE',
                                         :uid_type  => :sop_class },
    '1.2.840.10008.5.1.4.34.6.5'    => { :uid_value => '1.2.840.10008.5.1.4.34.6.5',
                                         :uid_name  => 'Unified Procedure Step - Query SOP Class',
                                         :uid_type  => :sop_class },
    '1.2.840.10008.1.2.4.70'        => { :uid_value => '1.2.840.10008.1.2.4.70',
                                         :uid_name  => "JPEG Lossless, Non-Hierarchical, First-Order Prediction (Process 14 [Selection Value 1]): Default Transfer Syntax for Lossless JPEG Image Compression",
                                         :uid_type  => :transfer_syntax},
    '1.2.840.10008.1.2.4.60'        => { :uid_value => '1.2.840.10008.1.2.4.60',
                                         :uid_name  => 'JPEG Extended, Hierarchical (Process 1719) (Retired)',
                                         :uid_type  => :transfer_syntax }
  }.each do |uid, data|
    include_examples "Handle specific record", data[:uid_name],
                     uid, data, DcmDict::Dictionary::TheUidDictionary
  end

  [
    '1.2.abc.3.4', 'this string is not a valid uid', '1.2.3.04.5'
  ].each do |uid|
    include_examples "Dictionary with wrong key",
                     uid, [:uid_value, :uid_name, :uid_type],
                     DcmDict::Dictionary::TheUidDictionary
  end

  include_examples "Dictionary Data not modifiable",
                   '1.2.840.10008.1.2', :uid_value, DcmDict::Dictionary::TheUidDictionary


  include_examples "Concurrency support",
                   '1.2.840.10008.1.2',
                   DcmDict::Dictionary::TheUidDictionary,
                   {uid_value: '1.2.840.10008.1.2',
                    uid_name: "Implicit VR Little Endian: Default Transfer Syntax for DICOM",
                    uid_type: :transfer_syntax}

end
