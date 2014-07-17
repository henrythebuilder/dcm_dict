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
require 'nokogiri'

module DcmDict
  module XML
    using DcmDict::StringRefine
    NODE_SET_IDX = { tag_str: 0,
                     tag_name: 1,
                     tag_key: 2,
                     tag_vr: 3,
                     tag_vm: 4,
                     tag_note: 5 }

    def self.extract_node_set_data(node_set)
      data = {}
      NODE_SET_IDX.each do |sym, idx|
        data[sym] = node_set[idx].content.dcm_unspace
      end
      data[:tag_sym] = data[:tag_key].tag_key_to_sym
      data[:tag_num] = data[:tag_str].tag_str_to_digit_str
      data[:tag_ary] = data[:tag_str].tag_str_to_ary
      data
    end
  end
end
