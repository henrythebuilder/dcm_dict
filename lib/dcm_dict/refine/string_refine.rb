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
  module StringRefine
    refine String do

      # remove zero width spaces
      def dcm_unspace
        zero_width_space = "\u200B"
        self.gsub(zero_width_space, '').strip
      end

      # 'PatientName' -> :patient_name
      def tag_key_to_sym
        self.gsub(/([^\A])([A-Z])([a-z])/,'\1_\2\3').
          gsub(/([a-z])([A-Z])/,'\1_\2').
          downcase.
          to_sym
      end

      # (0010,0010) -> '00100010'
      def tag_str_to_digit_str
        self.gsub(/[\(|\),]/, '')
      end

      # (0010,0010) -> [0x0010, 0x0010]
      def tag_str_to_ary
        self.gsub(/[\(|\)]/, '').
          split(',').
          map(&:hex)
      end

    end
  end
end
