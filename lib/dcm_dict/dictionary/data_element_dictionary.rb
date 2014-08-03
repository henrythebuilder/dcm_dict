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
  module Dictionary
    DataElementIndexKey = [:tag_ps, :tag_name, :tag_key, :tag_str, :tag_sym, :tag_ndm, :tag_ary]

    # Main class to handle data element data as dictionary
    class DataElementDictionary
      using DcmDict::Refine::Internal::ArrayRefineInternal
      using DcmDict::Refine::Internal::StringRefineInternal

      Semaphore = Mutex.new

      def initialize
        map_source_data
        freeze_source_data
      end

      def feature_of(tag)
        Semaphore.synchronize { atomic_feature_of(tag) }
      end

      private
      def map_source_data
        @standard_dict = {}
        @multi_dict = []
        SourceData::DataElementsData.each do |data|
          record = DataElementRecord.new(data)
          record.freeze
          DataElementIndexKey.each do |key|
            @standard_dict[data[key]] = record
          end
          @multi_dict << record if record.tag_multiple?
        end
      end

      def freeze_source_data
        @standard_dict.freeze
        @multi_dict.freeze
      end

      def atomic_feature_of(tag)
        try_to_find(tag)
      rescue
        raise DictionaryError.new("Unable to find reference for tag '#{tag}' as #{tag.class}")
      end

      def try_to_find(tag)
        try_to_find_standard_tag(tag) ||
          try_to_find_multiple_tag(tag) ||
          try_to_group_length_tag(tag) ||
          try_to_find_private_creator_tag(tag) ||
          try_to_find_unknown_tag(tag)
      end

      def try_to_find_standard_tag(tag)
        @standard_dict[tag]
      end

      def try_to_find_multiple_tag(tag)
        @multi_dict.each do |record|
          if (record.match_tag?(tag))
            return record.make_specific_record(tag)
          end
        end
        nil
      end

      def try_to_group_length_tag(tag)
        if (tag.tag_element == 0)
          return DataElementRecord.new(
                   SourceData::DetachedData.make_group_length_data(tag))
        end
        nil
      end

      def try_to_find_private_creator_tag(tag)
        if (tag.tag_group.odd? && tag.tag_element<0xff)
          return DataElementRecord.new(
                   SourceData::DetachedData.make_private_creator_data(tag))
        end
        nil
      end

      def try_to_find_unknown_tag(tag)
        DataElementRecord.new(
          SourceData::DetachedData.make_unknown_data(tag))
      end

    end
    TheDataElementDictionary = DataElementDictionary.new.freeze
  end
end
