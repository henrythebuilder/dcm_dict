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
module DcmDict
  module ArrayRefineInternal
    refine Array do
      def group
        check_dicom_tag
        self[0]
      end

      def element
        check_dicom_tag
        self[1]
      end

      def group_str
        group.to_s(16).rjust(4, '0').upcase()
      end

      def element_str
        element.to_s(16).rjust(4, '0').upcase()
      end

      def tag_str
        "(#{group_str},#{element_str})"
      end

      def tag_ary
        [group,element]
      end

      private
      def check_dicom_tag
        return true if ( (self.size==2) &&
                         self[0].is_a?(Integer) &&
                         self[1].is_a?(Integer))
        raise "Wrong object definition for Tag Array"
      end
    end
  end
end
