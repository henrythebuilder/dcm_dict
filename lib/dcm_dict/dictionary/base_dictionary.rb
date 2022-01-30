#
#  Copyright (C) 2014-2022  Enrico Rivarola
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

    # Base class for specific dictionary
    class BaseDictionary
      def initialize
        @semaphore = Mutex.new
        map_source_data
        freeze_source_data
      end

      # Find record data using +key+
      def record_at(key)
        @semaphore.synchronize { atomic_record_at(key) }
      end

      # Find single feature identified by +field+ for record indexed by +key+
      def feature_at(key, field)
        @semaphore.synchronize { atomic_feature_at(key, field) }
      end
    end

  end
end
