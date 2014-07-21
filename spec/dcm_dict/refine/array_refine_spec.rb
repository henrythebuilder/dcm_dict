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

describe "Array Refinement" do

  describe "should extract group and element from 'array tag'" do
    using DcmDict::ArrayRefine
    it "for correct object" do
      expect([0x0010,0x0020].group).to eq(0x0010)
      expect([0x0010,0x0020].element).to eq(0x0020)
    end

    describe "and for wrong array must be raise error" do
      [
        [0x0010],
        [0x0010,0x0020,0x0030],
        ['0010', '0020'],
        [16.0, 0x0020]
      ].each do |tag|
        it "as #{tag.inspect}" do
          expect{ tag.group }.to raise_error
          expect{ tag.element }.to raise_error

        end
      end
    end

  end

  describe "should convert group and element to four char hex string" do
    using DcmDict::ArrayRefine
    {
      [0xfffe,0xe0dd] => {group: 'FFFE', element: 'E0DD', tag_str: '(FFFE,E0DD)'},
      [0x0010,0x0020] => {group: '0010', element: '0020', tag_str: '(0010,0020)'}
    }.each do |tag, value|
      it "for #{tag.inspect}" do
        expect(tag.group_str).to eq(value[:group])
        expect(tag.element_str).to eq(value[:element])
        expect(tag.tag_str).to eq(value[:tag_str])
      end
    end
  end

end
