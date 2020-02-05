#
#  Copyright (C) 2014-2020  Enrico Rivarola
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
require 'data_element_sample_spec_helper'

describe "DcmDict::SourceData::DetachedData" do

  DataElementSampleSpecHelper.unknown_group_length_sample.each do |tag, expected_data|
    it "create data for 'group length' record for tag=#{tag.inspect}" do
      data = DcmDict::SourceData::DetachedData.make_group_length_data(tag)
      expected_data.each do |key, val|
        expect(data[key]).to eq(val)
      end
    end
  end

  DataElementSampleSpecHelper.private_creator_sample.each do |tag, expected_data|
    it "create data for 'private creator' record for tag=#{tag.inspect}" do
      data = DcmDict::SourceData::DetachedData.make_private_creator_data(tag)
      expected_data.each do |key, val|
        expect(data[key]).to eq(val)
      end
    end
  end

  DataElementSampleSpecHelper.unknown_sample.each do |tag, expected_data|
    it "create data for 'unknown tag' record for tag=#{tag.inspect}" do
      data = DcmDict::SourceData::DetachedData.make_unknown_data(tag)
      expected_data.each do |key, val|
        expect(data[key]).to eq(val)
      end
    end
  end
end
