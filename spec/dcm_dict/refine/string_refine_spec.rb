# coding: utf-8

#  This file is part of DcmDict gem (dcm_dict).
#
#  DcmDict is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 3 of the License, or
#  (at your option) any later version.
#
#  Foobar is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with Foobar.  If not, see <http://www.gnu.org/licenses/>.
#
require 'spec_helper'

module DcmDict
  describe "String refinement" do
    using DcmDict::StringRefine
    [
      ["FileSetDescriptorFileID ", "trailing spaces"],
      ["  FileSetDescriptorFileID", "leading spaces"],
      ["  FileSetDescriptorFileID  ", "leading and trailing spaces"],
      ["File​Set​Descriptor​FileID", "zero width spaces"],
      ["  File​Set​Descriptor​FileID  ", "leading, trailing and zero width spaces"]
    ].each do |wrong_string, comment|
      it "may remove unwanted space such as '#{comment}'" do
        expect(wrong_string.dcm_unspace).to eq('FileSetDescriptorFileID')
      end
    end
  end
end
