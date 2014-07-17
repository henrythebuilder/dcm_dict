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
      def dcm_unspace
        zero_width_space = "\u200B"
        self.gsub(zero_width_space, '').strip
      end

      def dcm_methodize_key
        self.gsub(/([^\A])([A-Z])([a-z])/,'\1_\2\3').
          gsub(/([a-z])([A-Z])/,'\1_\2').
          downcase.to_sym
      end

      def dcm_tag_to_numeric_string
        self.gsub(/[\(|\),]/, '')
      end

      def dcm_tag_to_ary
        self.gsub(/[\(|\)]/, '').split(',').map{|s| s.hex}
      end
    end
  end
end
