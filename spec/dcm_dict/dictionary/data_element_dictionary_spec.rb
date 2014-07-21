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
require 'data_element_sample_spec_helper'

describe DcmDict::Dictionary::DataElementDictionary do
  it "should map all source data" do
    index_keys = [:tag_ps, :tag_name, :tag_key, :tag_str, :tag_sym, :tag_ndm, :tag_ary]
    DcmDict::SourceData::DataElementsData.each do |record|
      index_keys.each do |key|
        obj = DcmDict::Dictionary::TheDataElementDictionary.feature_of(record[key])
        expect(obj).not_to be_nil, "#{key.inspect} > #{record[:tag_ps]}"
        expect(obj).to be_a(DcmDict::DataElementRecord)
      end
    end
  end

  DataElementSampleSpecHelper.unknown_group_length_sample.
    merge(DataElementSampleSpecHelper.known_group_length_sample).
    merge(DataElementSampleSpecHelper.private_creator_sample).
    merge(DataElementSampleSpecHelper.unknown_sample).each do |tag, data|
    it "should handling special case for tag = #{tag.inspect}" do
      obj = DcmDict::Dictionary::TheDataElementDictionary.feature_of(tag)
      expect(obj).not_to be_nil, "#{tag.inspect} not found into dictionary"
      data.each do |key, value|
        field = obj.send(key)
        expect(field).to eq(value)
      end
    end
  end

  DataElementSampleSpecHelper.multiple_tag_sample.each do |tag, data|
    it "should handling multiple tag (#{tag.inspect})" do
      obj = DcmDict::Dictionary::TheDataElementDictionary.feature_of(tag)
      data.each do |key, value|
        field = obj.send(key)
        expect(field).to eq(value)
      end

    end
  end
end
