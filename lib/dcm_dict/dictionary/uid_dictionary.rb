
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
    using DcmDict::Refine::Internal::StringRefineInternal

    UidIndexKey = [:uid_value, :uid_name]

    # Main class to handle uid data as dictionary
    class UidDictionary

      def initialize
        @dict={}
        map_source_data
      end

      def feature_of(uid)
        try_to_find_uid(uid)
      rescue => ex
        raise DictionaryError.new(ex.message)
      end

      private
      def map_source_data
        SourceData::UidValuesData.each do |data|
          record = UidRecord.new(data)
          UidIndexKey.each do |key|
            @dict[data[key]] = record
          end
        end
      end

      def try_to_find_uid(uid)
        @dict[uid] ||
          try_to_find_unknown_uid(uid)
      end

      def try_to_find_unknown_uid(uid)
        raise "Unknown UID value" unless uid.uid_value?
        UidRecord.new({ uid_value: uid,
                        uid_name: 'Unknown UID',
                        uid_type: :unknown })
      end
    end
    TheUidDictionary = UidDictionary.new
  end
end
