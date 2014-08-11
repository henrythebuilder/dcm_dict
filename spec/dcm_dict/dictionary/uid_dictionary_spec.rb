
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

  it "should map all source data" do
    index_keys = [:uid_value, :uid_name]
    DcmDict::SourceData::UidValuesData.each do |record|
      index_keys.each do |key|
        obj = DcmDict::Dictionary::TheUidDictionary.record_at(record[key])
        expect(obj).not_to be_nil, "#{key.inspect} > #{record[:uid_value]}"
        expect(obj).to be_a(DcmDict::Dictionary::UidRecord)
        expect(obj).to be_frozen
        [:uid_value, :uid_name, :uid_type].each do |field|
          feature = DcmDict::Dictionary::TheUidDictionary.feature_at(record[key], field)
          expect(feature).to eq(record[field])
        end
      end
    end
  end

  {
    '1.2.3.4.5.6' => { :uid_value => '1.2.3.4.5.6',
                       :uid_name => 'Unknown UID',
                       :uid_type => :unknown }
  }.each do |uid, data|
    it "should handling unknown value for uid = #{uid.inspect}" do
      obj = DcmDict::Dictionary::TheUidDictionary.record_at(uid)
      expect(obj).not_to be_nil, "#{uid.inspect} not found into dictionary"
      data.each do |key, value|
        field = obj.send(key)
        expect(field).to eq(value)
        feature = DcmDict::Dictionary::TheUidDictionary.feature_at(uid, key)
        expect(feature).to eq(value)
      end
    end
  end

  [
    '1.2.abc.3.4', 'this string is not a valid uid', '1.2.3.04.5'
  ].each do |uid|
    it "should raise exception for wrong value for uid as #{uid.inspect}" do
      expect{DcmDict::Dictionary::TheUidDictionary.record_at(uid)}.
        to raise_error(DcmDict::DictionaryError)
      [:uid_value, :uid_name, :uid_type].each do |field|
        expect { DcmDict::Dictionary::TheUidDictionary.feature_at(uid, field) }.
          to raise_error(DcmDict::DictionaryError)
      end
    end
  end

  it "data should be not modifiable" do
    expect(DcmDict::Dictionary::TheUidDictionary).to be_frozen
    uid  = '1.2.840.10008.1.2'
    obj = DcmDict::Dictionary::TheUidDictionary.record_at(uid)
    expect{obj.uid_value << 'aaa'}.to raise_error
    expect { DcmDict::Dictionary::TheUidDictionary.
             feature_at(tag, :tag_ps) << 'aaa' }.to raise_error
  end

  include_examples "Concurrency support",
                   '1.2.840.10008.1.2',
                   DcmDict::Dictionary::TheUidDictionary,
                   { uid_value: '1.2.840.10008.1.2',
                     uid_name: "Implicit VR Little Endian: Default Transfer Syntax for DICOM",
                     uid_type: :transfer_syntax}
end
