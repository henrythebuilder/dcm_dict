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

  {
    [16,0] => {tag_ps: '(0010,0000)', tag_str: '(0010,0000)', tag_ary: [0x0010,0x0000],
               tag_sym: :_0010__group_length, tag_ndm: '00100000', tag_name: '0010 Group Length',
               tag_key: '_0010_GroupLength', tag_vr: [:UL], tag_vm: ['1'], tag_note: 'Dummy Record',
               tag_multiple: false},
    [0,0] => { tag_ps: '(0000,0000)', tag_name: "Command Group Length", tag_key: 'CommandGroupLength',
               tag_vr: [:UL], tag_vm: ["1"], tag_str: '(0000,0000)', tag_sym: :command_group_length,
               tag_ndm: '00000000', tag_ary: [0, 0], tag_multiple: false,
               tag_note: 'The even number of bytes from the end of the value field to the beginning of the next group.'},
    [0x4444,0x0000] => {tag_ps: '(4444,0000)', tag_str: '(4444,0000)', tag_ary: [0x4444,0x0000],
               tag_sym: :_4444__group_length, tag_ndm: '44440000', tag_name: '4444 Group Length',
               tag_key: '_4444_GroupLength', tag_vr: [:UL], tag_vm: ['1'], tag_note: 'Dummy Record',
               tag_multiple: false},
    [17,0] =>  {tag_ps: '(0011,0000)', tag_str: '(0011,0000)', tag_ary: [0x0011,0x0000],
               tag_sym: :_0011__group_length, tag_ndm: '00110000', tag_name: '0011 Group Length',
               tag_key: '_0011_GroupLength', tag_vr: [:UL], tag_vm: ['1'], tag_note: 'Dummy Record',
               tag_multiple: false},
    [17,5] => {tag_ps: '(0011,0005)', tag_str: '(0011,0005)', tag_ary: [0x0011,0x0005],
               tag_sym: :private_creator, tag_ndm: '00110005', tag_name: 'Private Creator',
               tag_key: 'PrivateCreator', tag_vr: [:LO], tag_vm: ['1'], tag_note: 'Dummy Record',
               tag_multiple: false},
    [17,512] => {tag_ps: '(0011,0200)', tag_str: '(0011,0200)', tag_ary: [0x0011,0x0200],
               tag_sym: :unknown_tag, tag_ndm: '00110200', tag_name: 'Unknown Tag',
               tag_key: 'UnknownTag', tag_vr: [:UN], tag_vm: ['1'], tag_note: 'Dummy Record',
               tag_multiple: false}
  }.each do |tag, data|
    it "should handling special case for tag = #{tag.inspect}" do
      obj = DcmDict::Dictionary::TheDataElementDictionary.feature_of(tag)
      expect(obj).not_to be_nil, "#{tag.inspect} not found into dictionary"
      data.each do |key, value|
        field = obj.send(key)
        expect(field).to eq(value)
      end
    end
  end
end
