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
    using DcmDict::Refine::Internal::StringRefineInternal

    UidIndexKey = [:uid_value, :uid_name]

    # Main class to handle uid data as dictionary
    class UidDictionary

      Semaphore = Mutex.new

      def initialize
        map_source_data
      end

      def record_at(uid)
        Semaphore.synchronize { atomic_record_at(uid) }
      end

      private
      def map_source_data
        @dict={}
        SourceData::UidValuesData.each do |data|
          record = UidRecord.new(data)
          record.freeze
          UidIndexKey.each do |key|
            @dict[data[key]] = record
          end
        end
      end

      def atomic_record_at(uid)
        try_to_find_uid(uid)
      rescue Exception => ex
        raise DictionaryError.new("Unable to find reference for uid '#{uid}' as #{uid.class} (#{ex.class}: #{ex.message.inspect})")
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
    TheUidDictionary = UidDictionary.new.freeze
  end
end
