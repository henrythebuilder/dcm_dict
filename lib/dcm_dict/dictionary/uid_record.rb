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
    UidMethodMap = {uid_value: :uid_value,
                    uid_name: :uid_name,
                    uid_type: :uid_type }

    class UidRecord
      def initialize(data)
        initialize_data(data)
      end

      def method_missing(name, *args, &block)
        name_as_sym = name.to_sym
        return @data[UidMethodMap[name_as_sym]] if (UidMethodMap.has_key?(name_as_sym))
        return @data[name_as_sym] if (@data.has_key?(name_as_sym))
        super
      end

      private
      def respond_to_missing?(name, include_priv)
        UidMethodMap.has_key?(name) || @data.has_key?(name)
      end

      def initialize_data(data)
        @data = data
        freeze_data
      end

       def freeze_data
        @data.each {|key, value| value.freeze }
        @data.freeze
      end

    end
  end
end