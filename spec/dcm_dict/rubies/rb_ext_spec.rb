#
#  Copyright (C) 2014-2017  Enrico Rivarola
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

describe "Rubies dedicate extension" do
  it "should check for Fixnum::bit_length method" do
    {(-2**12-1) => 13,
     (-2**12)   => 12,
     (-2**12+1) => 12,
     -0x101    => 9,
     -0x100    => 8,
     -0xff     => 8,
     -2        => 1,
     -1        => 0,
     0         => 0,
     1         => 1,
     0xff      => 8,
     0x100     => 9,
     (2**12-1) => 12,
     (2**12)   => 13,
     (2**12+1) => 13}.each do |num, expected_bit_length|
      expect(num.bit_length).to eq(expected_bit_length)
    end
  end
end
