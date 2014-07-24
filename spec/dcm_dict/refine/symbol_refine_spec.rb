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
describe "Symbol refinement" do
  using DcmDict::Refine::SymbolRefine
  describe "should permit access to single data element dictionary information" do
    describe "for standard tag" do
      [
        :patient_birth_name, :gray_lookup_table_data, :dark_current_counts
      ].each do |tag|
        describe "#{tag}" do
          obj = DcmDict::Dictionary::TheDataElementDictionary.feature_of(tag)
          DcmDict::Dictionary::DataElementMethodMap.flatten.uniq.each do |method|
            it "as #{tag.inspect}.#{method.to_s} > #{obj.send(method).inspect}" do
              value = eval("#{tag.inspect}.#{method.to_s}")
              expect(value).to eq(obj.send(method))
            end
          end
        end
      end
    end

  end

  it "should get single 'information record' for a data element with 'data_element' method" do
    value = :patient_birth_name.data_element
    expect(value).to be_a(DcmDict::Dictionary::DataElementRecord)
  end

end
