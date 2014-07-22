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
  module Dictionary

    # Main class to handle data element data as dictionary
    class DataElementDictionary
      using DcmDict::Refine::Internal::ArrayRefineInternal
      using DcmDict::Refine::Internal::StringRefineInternal

      def initialize
        @index_keys = [:tag_ps, :tag_name, :tag_key, :tag_str, :tag_sym, :tag_ndm, :tag_ary]
        @standard_dict = {}
        @multi_dict = []
        map_source_data
      end

      def feature_of(tag)
        try_to_find(tag)
        rescue
          nil
      end

      private
      def map_source_data
        SourceData::DataElementsData.each do |data|
          record = DataElementRecord.new(data)
          @index_keys.each do |key|
            @standard_dict[data[key]] = record
          end
          @multi_dict << record if record.multiple_tag?
        end
      end

      def try_to_find(tag)
        @standard_dict[tag] ||
          try_to_find_multiple_tag(tag) ||
          try_to_find_unknown_tag(tag)
      end

      def try_to_find_multiple_tag(tag)
        @multi_dict.each do |record|
          if (record.match_tag?(tag))
            return record.make_specific_record(tag)
          end
        end
        nil
      end

      def try_to_find_unknown_tag(unknown_tag)
        tag = unknown_tag.to_tag_ary
        data = if tag[1] == 0
                 SourceData::DetachedData.make_group_length_data(tag)
               elsif tag[0].odd? and tag[1]<0xff
                 SourceData::DetachedData.make_private_creator_data(tag)
               else
                 SourceData::DetachedData.make_unknown_data(tag)
               end
        DataElementRecord.new(data)
      end

      def try_to_find_private_tag
      end
    end
    TheDataElementDictionary = DataElementDictionary.new
  end
end
