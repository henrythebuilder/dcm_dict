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

    # Class to handle uid data
    class UidFieldData < FieldData
      using DcmDict::Refine::Internal::StringRefineInternal
      using DcmDict::Refine::Internal::HashRefineInternal

      MISSING_NAME_VALUE = "(Retired)"

      # Initialize object using +extract_proc+ as proc to extract data from xml element
      def initialize(extract_proc)
        super
      end

      # Extract and build uid data
      def uid_data
        extract_base_data
        @data.check_base_data_uid_field!
        # extend_base_data
        @data
      end

      private
      def extract_base_data
        value = extract_content_data(:uid_value)
        type = extract_content_data(:uid_type).uid_type_to_sym
        key = extract_content_data(:uid_key)
        name = check_uid_name_for(extract_content_data(:uid_name), value, type)
        @data = { uid_value: value,
                  uid_name: name,
                  uid_type: type,
                  uid_key: key }
      end

      # def extend_base_data
      #   @data[:uid_sym] = @data[:uid_key].tag_key_to_sym
      # end

      # patch for 2016a source data ...
      def check_uid_name_for(name, value, type)
        name = "#{value} #{MISSING_NAME_VALUE}" if (name == MISSING_NAME_VALUE)
        name
      end
    end
  end
end
