#
#  Copyright (C) 2014-2017  Enrico Rivarola
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

describe "Array Refinement" do

  using DcmDict::Refine::Internal::ArrayRefineInternal
  it "should implement tag_ary metod" do
    expect([0x0010,0x0020].to_tag_ary).to eq([0x0010,0x0020])
  end

  describe "should extract group and element from 'array tag'" do
    it "for correct object" do
      expect([0x0010,0x0020].tag_group_num).to eq(0x0010)
      expect([0x0010,0x0020].tag_element_num).to eq(0x0020)
    end

    describe "and for wrong array must be raise error" do
      [
        [0x0010],
        [0x0010,0x0020,0x0030],
        ['0010', '0020'],
        [16.0, 0x0020],
        [0x1ffff,0x10000],
        [-1,-2]
      ].each do |tag|
        it "as #{tag.inspect}" do
          expect{ tag.tag_group_num }.to raise_error(RuntimeError)
          expect{ tag.tag_element_num }.to raise_error(RuntimeError)

        end
      end
    end

  end

  describe "should convert group and element to hex string" do
    {
      [0xfffe,0xe0dd] => {group: 'FFFE', element: 'E0DD', tag_str: '(FFFE,E0DD)', tag_ndm: 'FFFEE0DD'},
      [0x0010,0x0020] => {group: '0010', element: '0020', tag_str: '(0010,0020)', tag_ndm: '00100020'}
    }.each do |tag, value|
      it "for #{tag.inspect}" do
        expect(tag.tag_group_str).to eq(value[:group])
        expect(tag.tag_element_str).to eq(value[:element])
        expect(tag.to_tag_str).to eq(value[:tag_str])
        expect(tag.to_tag_ndm).to eq(value[:tag_ndm])
      end
    end
  end

  describe "should check for group-length tag" do
    {
      [0x0010, 0x0020] => false,
      [0x0010, 0x0000] => true,
      [0x0000, 0x0002] => false,
      [0x0000, 0x0000] => true
    }.each do |tag, value|
      it "for #{tag.inspect}" do
        expect(tag.group_length_tag?).to eq(value)
      end
    end
  end

  describe "should check for private-creator tag" do
    {
      [0x0010, 0x0010] => false,
      [0x0011, 0x0010] => true,
      [0x0011, 0x0110] => false,
      [0x0028, 0x2468] => false
    }.each do |tag, value|
      it "for #{tag.inspect}" do
        expect(tag.private_creator_tag?).to eq(value)
      end
    end
  end

end
