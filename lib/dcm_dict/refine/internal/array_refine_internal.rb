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
module DcmDict
  module Refine
    module Internal
      module ArrayRefineInternal

        refine Array do
          def tag_group_num
            check_dicom_tag
            self[0]
          end

          def tag_element_num
            check_dicom_tag
            self[1]
          end

          def tag_group_str
            tag_group_num.to_s(16).rjust(4, '0').upcase()
          end

          def tag_element_str
            tag_element_num.to_s(16).rjust(4, '0').upcase()
          end

          def to_tag_str
            "(#{tag_group_str},#{tag_element_str})"
          end

          def to_tag_ndm
            "#{tag_group_str}#{tag_element_str}"
          end

          def to_tag_ary
            [tag_group_num, tag_element_num]
          end

          def group_length_tag?
            tag_element_num == 0
          end

          def private_creator_tag?
            (tag_group_num.odd? && (tag_element_num < 0xff))
          end

          private
          def check_dicom_tag
            return true if ( (self.size==2) &&
                             valid_tag_value?(0) &&
                             valid_tag_value?(1) )
            raise "Wrong object definition for Tag Array"
          end

          def valid_tag_value?(index)
            value = self[index]
            return true if ( (value.is_a?(Integer)) &&
                             (value.bit_length <=16) &&
                             (value >=0) )
            raise "Wrong value at index #{index} for Tag Array"
          end
        end

      end
    end
  end
end
