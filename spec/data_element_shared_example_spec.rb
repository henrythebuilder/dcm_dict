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

using DcmDict::Refine::ArrayRefine
using DcmDict::Refine::StringRefine
using DcmDict::Refine::SymbolRefine

RSpec.shared_examples "refinement for standard tag" do |tags, tag_proc|
  describe "for standard tag" do
    tags.each do |tag|
      describe "as #{tag_proc.call(tag)}" do
        obj = DcmDict::Dictionary::TheDataElementDictionary.feature_of(tag)
        DcmDict::Dictionary::DataElementMethodMap.
          merge({group: :group, element: :element}).
          flatten.uniq.each do |method|
          expr = "#{tag_proc.call(tag)}.#{method.to_s}"
          it "with #{expr} > #{obj.send(method).inspect}" do
            value = eval(expr)
            expect(value).to eq(obj.send(method))
          end
        end
      end
    end
  end
end

RSpec.shared_examples "refinement for multiple tag" do |tag_data, tag_proc|
  describe "for multiple tag" do
    tag_data.each do |tag, data|
      data.each do |key, exp_value|
        expr = "#{tag_proc.call(tag)}.#{key}"
        it "as #{expr} > #{exp_value.inspect}" do
          value = eval(expr)
          expect(value).to eq(exp_value)
        end
      end
    end
  end
end

RSpec.shared_examples "should get data element record" do |tag_data, tag_proc|
  describe "should get single 'information record' for a data element" do
    tag_data.each do |tag|
      expr = "#{tag_proc.call(tag)}.data_element"
      it "as #{tag.inspect} with #{expr}" do
        value = eval(expr)
        expect(value).to be_a(DcmDict::Dictionary::DataElementRecord)
      end
    end
  end
end
