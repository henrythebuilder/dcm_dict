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
describe "DcmDict::SourceData::DetachedData" do

  {
    [16,0] => {tag_ps: '(0010,0000)',
               tag_str: '(0010,0000)',
               tag_ary: [0x0010,0x0000],
               tag_sym: :_0010__group_length,
               tag_ndm: '00100000',
               tag_name: '0010 Group Length',
               tag_key: '_0010_GroupLength',
               tag_vr: [:UL],
               tag_vm: ['1'],
               tag_note: 'Dummy Record',
               tag_multiple: false}
  }.each do |tag, expected_data|
    it "create data for 'group length' record for tag=#{tag.inspect}" do
      data = DcmDict::SourceData::DetachedData.make_group_length_data(tag)
      expected_data.each do |key, val|
        expect(data[key]).to eq(val)
      end
    end
  end

  {
    [17,5] => {tag_ps: '(0011,0005)', tag_str: '(0011,0005)', tag_ary: [0x0011,0x0005],
               tag_sym: :private_creator, tag_ndm: '00110005', tag_name: 'Private Creator',
               tag_key: 'PrivateCreator', tag_vr: [:LO], tag_vm: ['1'], tag_note: 'Dummy Record',
               tag_multiple: false}
  }.each do |tag, expected_data|
    it "create data for 'private creator' record for tag=#{tag.inspect}" do
      data = DcmDict::SourceData::DetachedData.make_private_creator_data(tag)
      expected_data.each do |key, val|
        expect(data[key]).to eq(val)
      end
    end
  end

  {
    [17,512] => {tag_ps: '(0011,0200)', tag_str: '(0011,0200)', tag_ary: [0x0011,0x0200],
               tag_sym: :unknown_tag, tag_ndm: '00110200', tag_name: 'Unknown Tag',
               tag_key: 'UnknownTag', tag_vr: [:UN], tag_vm: ['1'], tag_note: 'Dummy Record',
               tag_multiple: false}
  }.each do |tag, expected_data|
    it "create data for 'unknown tag' record for tag=#{tag.inspect}" do
      data = DcmDict::SourceData::DetachedData.make_unknown_data(tag)
      expected_data.each do |key, val|
        expect(data[key]).to eq(val)
      end
    end
  end
end
