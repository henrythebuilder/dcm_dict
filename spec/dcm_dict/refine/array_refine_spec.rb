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
describe "Array refinement" do
  using DcmDict::Refine::ArrayRefine
  describe "should permit access to single data element dictionary information" do
    describe "for standard tag" do
      [
        '[0x0010,0x1005]'#, '(60XX,0040)', '(0028,1200)', '(0014,3050)'
      ].each do |stag|
        describe "#{stag}" do
          tag = eval(stag)
          obj = DcmDict::Dictionary::TheDataElementDictionary.feature_of(tag)
          DcmDict::Dictionary::DataElementMethodMap.flatten.uniq.each do |method|
            it "as #{stag}.#{method.to_s} > #{obj.send(method).inspect}" do
              value = eval("#{stag}.#{method.to_s}")
              expect(value).to eq(obj.send(method))
            end
          end
        end
      end
    end

    describe "for multiple tag" do
      {
        '[0x6046,0x0040]' => { name: "Overlay Type",
                           tag_multiple: true,
                           tag_name: "Overlay Type",
                           keyword: "OverlayType",
                           tag_key: "OverlayType",
                           vr: [:CS], tag_vr: [:CS], vm: ["1"], tag_vm: ["1"],
                           tag: [0x6046, 0x0040], tag_ary: [0x6046, 0x0040],
                           tag_ps: "(60XX,0040)",
                           tag_sym: :overlay_type,
                           tag_ndm: "60460040",
                           tag_str: "(6046,0040)" }
      }.each do |stag, data|
        data.each do |key, exp_value|
          it "as #{stag}.#{key} > #{exp_value.inspect}" do
            value = eval("#{stag}.#{key}")
            expect(value).to eq(exp_value)
          end
        end
      end
    end
  end

  it "should get single 'information record' for a data element with 'data_element' method" do
    value = [0x0010,0x1005].data_element
    expect(value).to be_a(DcmDict::Dictionary::DataElementRecord)
  end

end
