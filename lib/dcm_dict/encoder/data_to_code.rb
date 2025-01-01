#
#  Copyright (C) 2014-2025  Enrico Rivarola
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
  module Encoder
    module DataToCode
      using DcmDict::Refine::Internal::ArrayRefineInternal

      # Convert data element +data+ to Ruby code using +indent+ spaces indentation
      def self.data_element_data_to_code(data, indent=4)
        indent = 4 unless indent
        tag_ary_str = "[0x#{data[:tag_ary].tag_group_str},0x#{data[:tag_ary].tag_element_str}]"
        "#{' '*indent}{ tag_ps: '#{data[:tag_ps]}', tag_name: \"#{data[:tag_name]}\", tag_key: '#{data[:tag_key]}', tag_vr: #{data[:tag_vr]}, tag_vm: #{data[:tag_vm]}, tag_str: '#{data[:tag_str]}', tag_sym: #{data[:tag_sym].inspect}, tag_ndm: '#{data[:tag_ndm]}', tag_ary: #{tag_ary_str}, tag_multiple: #{data[:tag_multiple].inspect}, tag_note: '#{data[:tag_note]}'},"
      end

      # Source data element header
      def self.data_element_header
        <<END
module DcmDict
  module SourceData
    DataElementsData = [
END
      end

      # Source data element footer
      def self.data_element_footer
        <<END
    ]
  end
end
END
      end

      # Source uid header
      def self.uid_header
        <<END
module DcmDict
  module SourceData
    UidValuesData = [
END
      end

      # Source uid footer
      def self.uid_footer
        <<END
    ]
  end
end
END
      end

      # Convert uid +data+ to Ruby code using +indent+ spaces indentation
      def self.uid_data_to_code(data, indent=4)
        indent = 4 unless indent
        "#{' '*indent}{ uid_value: '#{data[:uid_value]}', uid_name: '#{data[:uid_name]}', uid_key: '#{data[:uid_key]}', uid_sym: #{data[:uid_sym].inspect}, uid_type: #{data[:uid_type].inspect}},"
      end
    end
  end
end
