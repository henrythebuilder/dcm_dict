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

describe "Symbol refinement" do
  using DcmDict::Refine::SymbolRefine
  describe "should permit access to single data element dictionary information" do

    include_examples "refinement for standard tag",
                     [:patient_birth_name, :gray_lookup_table_data, :dark_current_counts],
                     Proc.new{|tag| tag.inspect}

  end

  include_examples "Raise exception for wrong input",
                   [ :wrong_data_element ],
                   [],
                   Proc.new {|tag| tag.inspect}

end
