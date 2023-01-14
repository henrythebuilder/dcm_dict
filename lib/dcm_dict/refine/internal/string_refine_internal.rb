# coding: utf-8
#
#  Copyright (C) 2014-2023  Enrico Rivarola
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

          # Remove zero width spaces (-> "​") and leading/trailing whitespace
          def dcm_unspace
            zero_width_space = "\u200B"
            self.gsub(zero_width_space, '').strip
          end

          # Convert tag key to tag symbol -> 'PatientName' -> :patient_name
          def tag_key_to_sym
            self.gsub('IDs', 'IDS').
              gsub('3D', '_3D').
              gsub('RTROI', 'RT_ROI').
              gsub('DVHROI', 'DVH_ROI').
              gsub('OCTZ', 'OCT_Z').
              gsub('WADORS', 'WADO_RS').
              gsub('STOWRS', 'STOW_RS').
              gsub('CIExy', 'CIEXY').
              gsub('RGBLUT', 'RGB_LUT').
              gsub('VOILUT', 'VOI_LUT').
              gsub('CTDIvol', 'CTDIVol').
              gsub('XAXRF', 'XA_XRF').
              gsub('CurrentInuA', 'Current_in_ua_').
              gsub('TimeInuS', 'Time_in_us').
              gsub('ExposureInuAs', 'Exposure_in_uas_').
              gsub('dBdt', '_db_dt_').
              gsub(/([A-Z])([a-z])/,'_\1\2').
              gsub(/([a-z])([A-Z])/,'\1_\2').
              gsub(/\A_/,'').
              gsub(/_\z/,'').
              downcase.
              to_sym
          end

          # Tag group as number
          def tag_group_num
            tag_group_str.hex
          end

          # Tag element as number
          def tag_element_num
            tag_element_str.hex
          end

          # Tag group as string
          def tag_group_str
            self.to_tag_ndm[0..3]
          end

          # Tag element as string
          def tag_element_str
            self.to_tag_ndm[4..7]
          end

          # Tag as Native Dicom Model tag ('(0010,0010)' -> '00100010')
          def to_tag_ndm
            check_dicom_tag
            self.gsub(/[\(|\),]/, '').upcase
          end

          # Tag as array ('(0010,0010)' -> [0x0010, 0x0010])
          def to_tag_ary
            [tag_group_num, tag_element_num]
          end

          # Tag as string ('00100010'/'(0010,0010)' -> '(0010,0010)')
          def to_tag_str
            "(#{tag_group_str},#{tag_element_str})"
          end

          # Convert uid type to symbol
          def uid_type_to_sym
            self.gsub(/[ -\/]/, '_').
              downcase.
              to_sym
          end

          # Check for valid uid value
          def uid_value?
            (self.length <= 64) &&
              (/^(([0-9][\.])|([1-9][0-9]*[\.]))*(([0-9])|([1-9][0-9]*))$/.match(self) != nil)
          end

          # Check for group length tag
          def group_length_tag?
            tag_element_num == 0
          end

          # Check for private creator tag
          def private_creator_tag?
            (tag_group_num.odd? && (tag_element_num < 0xff))
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
