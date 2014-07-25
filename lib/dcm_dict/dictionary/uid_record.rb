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
    UidMethodMap = {uid_value: :uid_value,
                    uid_name: :uid_name,
                    uid_type: :uid_type }

    class UidRecord
      def initialize(data)
        @data = data
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

    end
  end
end
