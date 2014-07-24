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
  module XML
    class UidFieldData < FieldData

      def initialize(extract_proc)
        super
      end

      def uid_data
        extract_base_data
      end

      private
      def extract_base_data
        { uid_value: extract_content_data(:uid_value),
          uid_name: extract_content_data(:uid_name),
          uid_type: extract_content_data(:uid_type)}
      end
    end
  end
end
