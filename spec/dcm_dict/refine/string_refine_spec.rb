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
describe "string refinement" do
  describe "should permit to access data element dictionary information" do
    using DcmDict::Refine::StringRefine
    [
      "(0010,1005)", '(60XX,0040)', '(0028,1200)', '(0014,3050)'
    ].each do |tag|
      describe "for tag #{tag}" do
        obj = DcmDict::Dictionary::TheDataElementDictionary.feature_of(tag)
        [:tag_ps, :tag_name, :tag_key, :tag_str, :tag_ndm].each do |key|
          DcmDict::Dictionary::DataElementMethodMap.flatten.uniq.each do |method|
            it "as #{obj.send(key).inspect}.#{method.to_s} > #{obj.send(method).inspect}" do
              value = eval("\"#{obj.send(key)}\".#{method.to_s}")
              expect(value).to eq(obj.send(method))
            end
          end
        end
      end
    end

  end
end
