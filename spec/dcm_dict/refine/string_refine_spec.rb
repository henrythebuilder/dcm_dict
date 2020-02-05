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

describe "String refinement" do
  using DcmDict::Refine::StringRefine
  describe "should permit access to single data element dictionary information" do

    include_examples "refinement for standard tag",
                     ["(0010,1005)", "Patient's Birth Name", "PatientBirthName", "(0010,1005)", "00101005",
                      '(60XX,0040)', "Overlay Type", "OverlayType", "(6022,0040)", "60220040",
                      '(0028,1200)', "Gray Lookup Table Data", "GrayLookupTableData", "(0028,1200)", "00281200",
                      '(0014,3050)', "Dark Current Counts", "DarkCurrentCounts", "(0014,3050)", "00143050",
                     ],
                     Proc.new{|tag| tag.inspect}


    multi_str_data = { '(6046,0040)' => {
                         tag_multiple: true,
                         tag_name: "Overlay Type",
                         tag_keyword: "OverlayType",
                         tag_key: "OverlayType",
                         tag_vr: [:CS], tag_vm: ["1"],
                         tag: [0x6046, 0x0040], tag_ary: [0x6046, 0x0040],
                         tag_ps: "(60XX,0040)",
                         tag_sym: :overlay_type,
                         tag_ndm: "60460040",
                         tag_str: "(6046,0040)",
                         tag_group: 0x6046,
                         tag_element: 0x0040 } }

    include_examples "refinement for multiple tag",
                     multi_str_data,
                     Proc.new {|tag| tag.inspect}

  end


  describe "should permit access to single data uid dictionary information" do
    describe "for regular uids" do
      [
        '1.2.840.10008.1.1', "Verification SOP Class",
        '1.2.840.10008.1.2.1', "Explicit VR Little Endian",
        '1.2.840.10008.5.1.4.1.2.1.1', "Patient Root Query/Retrieve Information Model - FIND",
        '1.2.3.4.5.6'
      ].each do |uid|
        describe "as #{uid.inspect}" do
          obj = DcmDict::Dictionary::TheUidDictionary.record_at(uid)
          DcmDict::Dictionary::UidMethod.each do |method|
            expr = "#{uid.inspect}.#{method.to_s}"
            it "with #{expr} > #{obj.send(method).inspect}" do
              value = eval(expr)
              expect(value).to eq(obj.send(method))
            end
          end
        end
      end
    end
  end

  include_examples "Raise exception for wrong input",
                   [ '123g123m' ],
                   [ 'this string is not an uid' ],
                   Proc.new {|tag| tag.inspect}

end
