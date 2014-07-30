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
      module StringRefineInternal

        refine String do
          # remove zero width spaces
          def dcm_unspace
            zero_width_space = "\u200B"
            self.gsub(zero_width_space, '').strip
          end

          # 'PatientName' -> :patient_name
          def tag_key_to_sym
            self.gsub('IDs', 'IDS').gsub('3D', '_3D').
              gsub(/([A-Z])([a-z])/,'_\1\2').
              gsub(/([a-z])([A-Z])/,'\1_\2').
              gsub(/^_/,'').
              downcase.
              to_sym
          end

          def tag_group
            tag_group_str.hex
          end

          def tag_element
            tag_element_str.hex
          end

          def tag_group_str
            self.to_tag_ndm[0..3]
          end

          def tag_element_str
            self.to_tag_ndm[4..7]
          end
          # (0010,0010) -> '00100010'
          #  00100010   -> '00100010'
          def to_tag_ndm
            check_dicom_tag
            self.gsub(/[\(|\),]/, '').upcase
          end

          # (0010,0010) -> [0x0010, 0x0010]
          def to_tag_ary
            [tag_group,tag_element]
          end

          # '00100010', (0010,0010) -> (0010,0010)
          def to_tag_str
            "(#{tag_group_str},#{tag_element_str})"
          end

          def uid_type_to_sym
            self.gsub(/[ -\/]/, '_').
              downcase.
              to_sym
          end

          def uid_value?
            (self.length <= 64) &&
              (/^(([0-9][\.])|([1-9][0-9]*[\.]))*(([0-9])|([1-9][0-9]*))$/.match(self) != nil)
          end

          private
          def check_dicom_tag
            return true if (/^[0-9|A-F]{8}$/.match(self) ||
                            /^[\(][0-9a-fA-F]{4}[\)\,\(][0-9a-fA-F]{4}\)$/.match(self))
            raise "wrong value for tag #{self.inspect}"
          end

        end

      end
    end
  end
end
