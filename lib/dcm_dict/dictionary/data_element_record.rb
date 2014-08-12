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
require_relative 'base_record'

module DcmDict
  module Dictionary
    DataElementMethodMap = { :tag_multiple? => :tag_multiple,
                             :tag_name => :tag_name,
                             :tag_keyword => :tag_key,
                             :tag_vr => :tag_vr,
                             :tag_vm => :tag_vm,
                             :tag_note => :tag_note,
                             :tag => :tag_ary,
                             :tag_ary => :tag_ary,
                             :tag_ps => :tag_ps,
                             :tag_sym => :tag_sym,
                             :tag_ndm => :tag_ndm,
                             :tag_str => :tag_str }.freeze

    DataElementMethod = DataElementMethodMap.flatten.
                        concat([:tag_group, :tag_element]).uniq.freeze

    # Class to handle data element record from source dictionary data
    class DataElementRecord < BaseRecord
      using DcmDict::Refine::Internal::StringRefineInternal
      using DcmDict::Refine::Internal::ArrayRefineInternal

      def initialize(data)
        super
      end

      def tag_group
        record_data[:tag_ary].tag_group_num
      end

      def tag_element
        record_data[:tag_ary].tag_element_num
      end

      def extract_multiple_tag_record(tag)
        if ( record_data[:tag_multiple] && match_tag?(tag) )
          DataElementRecord.new( record_data.merge( { tag_str: tag.to_tag_str,
                                                      tag_ndm: tag.to_tag_ndm,
                                                      tag_ary: tag.to_tag_ary } ))
        end
      end

      private
      def method_map
        DataElementMethodMap
      end

      def match_tag?(tag)
        tag_to_match = tag.to_tag_str
        tag_pattern.each do |pattern|
          re = Regexp.new(pattern)
          return true if re.match(tag_to_match)
        end
        false
      end

      def tag_pattern
        gs, es = self.tag_ps.gsub(/[\(|\)]/, '').gsub(/[xX]/,"[0-9A-Fa-f]").split(',')
        ["^\\(#{gs}\\,#{es}\\)$", "^#{gs}#{es}$" ]
      end

    end
  end
end
