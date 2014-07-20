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
    class DataElementDictionary
      def initialize
        @index_keys = [:tag_ps, :tag_name, :tag_key, :tag_str, :tag_sym, :tag_ndm, :tag_ary]
        @dict = {}
        map_source_data
      end
      def feature_of(tag)
        @dict[tag] ||
          try_to_find_unknown_tag(tag)
      end

      private
      def map_source_data
        SourceData::DataElementsData.each do |data|
          record = DataElementRecord.new(data)
          @index_keys.each do |key|
            @dict[data[key]] = record
          end
        end
      end

      def try_to_find_unknown_tag(unknown_tag)
         return nil unless unknown_tag.respond_to?(:to_ary)
         tag = unknown_tag.to_ary
         return nil unless tag.size == 2
         data = if tag[1] == 0
                  SourceData::DetachedData.make_group_length_data(tag)
                elsif tag[0].odd? and tag[1]<0xff
                  SourceData::DetachedData.make_private_creator_data(tag)
                else
                  SourceData::DetachedData.make_unknown_data(tag)
                end
         DataElementRecord.new(data)
      end
    end
    TheDataElementDictionary = DataElementDictionary.new
  end
end
