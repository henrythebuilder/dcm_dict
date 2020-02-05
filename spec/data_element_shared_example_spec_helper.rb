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
using DcmDict::Refine::ArrayRefine
using DcmDict::Refine::StringRefine
using DcmDict::Refine::SymbolRefine

RSpec.shared_examples "refinement for standard tag" do |tags, tag_proc|
  describe "for standard tag" do
    tags.each do |tag|
      describe "as #{tag_proc.call(tag)}" do
        obj = DcmDict::Dictionary::TheDataElementDictionary.record_at(tag)
        DcmDict::Dictionary::DataElementMethod.each do |method|
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
