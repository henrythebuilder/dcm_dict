#
#  Copyright (C) 2014-2020  Enrico Rivarola
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
  module XML
    MultiFieldSeparator = ' or '.freeze
    DefaultMultiTagValue = '2'.freeze

    # Class to handle data element data
    class TagFieldData < FieldData
      using DcmDict::Refine::Internal::StringRefineInternal
      using DcmDict::Refine::Internal::HashRefineInternal

      # Initialize object using +extract_proc+ as proc to extract data from xml element
      def initialize(extract_proc)
        super
      end

      # Extract and build data element data
      def data_element_data
        extract_base_data()
        @data.check_base_data_tag_field!
        extend_base_data()
        @data
      end

      private
      def extract_base_data()
        @data = { :tag_ps =>  extract_content_data(:tag_ps),
                  :tag_name =>  extract_content_data(:tag_name),
                  :tag_key =>  extract_content_data(:tag_key),
                  :tag_vr =>  extract_tag_vr(),
                  :tag_vm =>  extract_tag_vm(),
                  :tag_note => extract_content_data(:tag_note) }
      end

      def extract_tag_vr()
        extract_multiple_data(:tag_vr, MultiFieldSeparator).map(&:to_sym)
      end

      def extract_tag_vm()
        extract_multiple_data(:tag_vm, MultiFieldSeparator)
      end

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
