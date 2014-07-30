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
#  This software has neither been tested nor approved for clinical use
#  or for incorporation in a medical device.
#  It is the redistributor's or user's responsibility to comply with any
#  applicable local, state, national or international regulations.
#
RSpec.shared_examples "Record handle methods correctly" do |obj, data|
  it "Handle methods correctly" do
    data.each do |key, expected_val|
      expect(obj.respond_to?(key.to_sym)).to be true
      expect(obj.respond_to?(key.to_s)).to be true
    end

    expect(obj.respond_to?(:undefined_method_for_record)).to be false
    expect(obj.respond_to?(:undefined_method_for_record.to_s)).to be false
    expect{ obj.undefined_method_for_record }.to raise_error(NoMethodError)
    expect{ obj.send("undefined_method_for_record") }.to raise_error(NoMethodError)
  end
end
