#
#  Copyright (C) 2014-2019  Enrico Rivarola
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

RSpec.shared_examples "Raise exception for wrong input" do |tags, uids, tag_proc|
  describe "should raise exception for wrong input" do
    describe "for data element" do
      tags.each do |tag|
        DcmDict::Dictionary::DataElementMethod.each do |method|
          expr = "#{tag_proc.call(tag)}.#{method.to_s}"
          it "with #{expr}" do
#            expect{eval(expr)}.to raise_error(DcmDict::DictionaryError, "Unable to find reference for tag '#{tag}' as #{tag.class}")
            expect{eval(expr)}.to raise_error(DcmDict::DictionaryError)
          end
        end
      end
    end

    describe "and for uid" do
      uids.each do |uid|
        DcmDict::Dictionary::UidMethod.each do |method|
          expr = "#{uid.inspect}.#{method.to_s}"
          it "with #{expr}" do
#            expect{eval(expr)}.to raise_error(DcmDict::DictionaryError, "Unable to find reference for uid '#{uid}' as #{uid.class}")
            expect{eval(expr)}.to raise_error(DcmDict::DictionaryError)
          end
        end
      end
    end
  end
end
