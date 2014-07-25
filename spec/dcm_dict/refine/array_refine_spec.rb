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

    include_examples "refinement for standard tag",
                     [[0x0010,0x1005], [0x0028,0x1200], [0x0014,0x3050]],
                     Proc.new{|tag| tag}


    multi_data = { [0x6046,0x0040] => {
                     name: "Overlay Type",
                     tag_multiple: true,
                     tag_name: "Overlay Type",
                     keyword: "OverlayType",
                     tag_key: "OverlayType",
                     vr: [:CS], tag_vr: [:CS], vm: ["1"], tag_vm: ["1"],
                     tag: [0x6046, 0x0040], tag_ary: [0x6046, 0x0040],
                     tag_ps: "(60XX,0040)",
                     tag_sym: :overlay_type,
                     tag_ndm: "60460040",
                     tag_str: "(6046,0040)",
                     group: 0x6046,
                     element: 0x0040 } }

    include_examples "refinement for multiple tag",
                     multi_data,
                     Proc.new {|tag| tag}

  end

  include_examples "should get data element record",
                   [ [0x0010,0x1005] ],
                   Proc.new {|tag| tag}

end
