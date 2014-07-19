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

    NodeSetIdx = { tag_ps: 0,
                   tag_name: 1,
                   tag_key: 2,
                   tag_vr: 3,
                   tag_vm: 4,
                   tag_note: 5 }

    DefaultMultiTagValue = '2'
    MultiFieldSeparator = ' or '

    class NodeSetData
      using DcmDict::StringRefine

      def initialize(node_set)
        @node_set = node_set
      end

      def data_element_data
        extend_base_data( extract_base_data )
      end

      private
      def extract_base_data()
        {
          :tag_ps =>  extract_tag_ps(),
          :tag_name =>  extract_tag_name(),
          :tag_key =>  extract_tag_key(),
          :tag_vr =>  extract_tag_vr(),
          :tag_vm =>  extract_tag_vm(),
          :tag_note => extract_tag_note()
        }
      end

      def extract_tag_ps()
        extract_content_data(NodeSetIdx[:tag_ps])
      end

      def extract_tag_name()
        extract_content_data(NodeSetIdx[:tag_name])
      end

      def extract_tag_key()
        extract_content_data(NodeSetIdx[:tag_key])
      end

      def extract_tag_vr()
        extract_multiple_data(NodeSetIdx[:tag_vr]).map(&:to_sym)
      end

      def extract_tag_vm()
        extract_multiple_data(NodeSetIdx[:tag_vm])
      end

      def extract_tag_note()
        extract_content_data(NodeSetIdx[:tag_note])
      end

      def extend_base_data(data)
        data[:tag_str] = extract_tag_str_from_data(data)
        data[:tag_sym] = extract_tag_sym_from_data(data)
        data[:tag_ndm] = extract_tag_ndm_from_data(data)
        data[:tag_ary] = extract_tag_ary_from_data(data)
        data[:tag_multiple] = data_with_multiple_tag?(data)
        data
      end

      def extract_tag_str_from_data(data)
        data[:tag_ps].gsub(/[xX|]/, DefaultMultiTagValue)
      end

      def data_with_multiple_tag?(data)
        data[:tag_ps].index(/[xX|]/) ? true : false
      end

      def extract_tag_ary_from_data(data)
        data[:tag_str].tag_str_to_ary
      end

      def extract_tag_ndm_from_data(data)
        data[:tag_str].tag_str_to_digit_str
      end

      def extract_tag_sym_from_data(data)
        data[:tag_key].tag_key_to_sym
      end

      def extract_multiple_data(idx)
        extract_content_data(idx).split(MultiFieldSeparator)
      end

      def extract_content_data(idx)
        return '' unless @node_set[idx]
        @node_set[idx].content.dcm_unspace
      end

    end

  end
end
