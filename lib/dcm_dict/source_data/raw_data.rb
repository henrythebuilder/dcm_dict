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
  module SourceData
    DefaultMultiTagValue = '2'

    class RawData
      using DcmDict::Refine::Internal::StringRefineInternal
      using DcmDict::Refine::Internal::HashRefineInternal

      def initialize(data)
        @data = data
        @data.check_base_data_tag_field!
        extend_base_data
      end

      def data_element_record_data
        @data
      end

      private
      def extend_base_data
        @data[:tag_str] = extract_tag_str_from_data
        @data[:tag_sym] = extract_tag_sym_from_data
        @data[:tag_ndm] = extract_tag_ndm_from_data
        @data[:tag_ary] = extract_tag_ary_from_data
        @data[:tag_multiple] = data_with_multiple_tag?
      end
      def extract_tag_str_from_data
        @data[:tag_ps].gsub(/[xX|]/, DefaultMultiTagValue)
      end

      def data_with_multiple_tag?
        @data[:tag_ps].index(/[xX|]/) ? true : false
      end

      def extract_tag_ary_from_data
        @data[:tag_str].to_tag_ary
      end

      def extract_tag_ndm_from_data
        @data[:tag_str].to_tag_ndm
      end

      def extract_tag_sym_from_data
        @data[:tag_key].tag_key_to_sym
      end
    end

  end
end
