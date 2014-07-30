
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
        obj = DcmDict::Dictionary::TheUidDictionary.feature_of(record[key])
        expect(obj).not_to be_nil, "#{key.inspect} > #{record[:uid_value]}"
        expect(obj).to be_a(DcmDict::Dictionary::UidRecord)
      end
    end
  end

  {
    '1.2.3.4.5.6' => { :uid_value => '1.2.3.4.5.6',
                       :uid_name => 'Unknown UID',
                       :uid_type => :unknown }
  }.each do |uid, data|
    it "should handling unknown value for uid = #{uid.inspect}" do
      obj = DcmDict::Dictionary::TheUidDictionary.feature_of(uid)
      expect(obj).not_to be_nil, "#{uid.inspect} not found into dictionary"
      data.each do |key, value|
        field = obj.send(key)
        expect(field).to eq(value)
      end
    end
  end

  [
    '1.2.abc.3.4', 'this string is not a valid uid', '1.2.3.04.5'
  ].each do |uid|
    it "should raise exception for wrong value for uid as #{uid.inspect}" do
      expect{DcmDict::Dictionary::TheUidDictionary.feature_of(uid)}.
        to raise_error(DcmDict::DictionaryError)
    end
  end

end
