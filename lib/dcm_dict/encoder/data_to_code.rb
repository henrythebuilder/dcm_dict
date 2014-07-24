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
  module Encoder
    module DataToCode
      using DcmDict::Refine::Internal::ArrayRefineInternal

      def self.data_element_data_to_code(data, indent: 4)
        tag_ary_str = "[0x#{data[:tag_ary].group_str},0x#{data[:tag_ary].element_str}]"
        "#{' '*indent}{ tag_ps: '#{data[:tag_ps]}', tag_name: \"#{data[:tag_name]}\", tag_key: '#{data[:tag_key]}', tag_vr: #{data[:tag_vr]}, tag_vm: #{data[:tag_vm]}, tag_str: '#{data[:tag_str]}', tag_sym: #{data[:tag_sym].inspect}, tag_ndm: '#{data[:tag_ndm]}', tag_ary: #{tag_ary_str}, tag_multiple: #{data[:tag_multiple].inspect}, tag_note: '#{data[:tag_note]}'},"
      end

      def self.data_element_header
        <<END
module DcmDict
  module SourceData
    DataElementsData = [
END
      end

      def self.data_element_footer
        <<END
    ]
  end
end
END
      end

      def self.uid_header
        <<END
module DcmDict
  module SourceData
    UidValues = [
END
      end

      def self.uid_footer
        <<END
    ]
  end
end
END
      end

      def self.uid_data_to_code(data, indent: 4)
        "#{' '*indent}{ uid_value: '#{data[:uid_value]}', uid_name: \"#{data[:uid_name]}\", uid_type: '#{data[:uid_type]}'},"
      end
    end
  end
end
