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
    class FieldData
      using DcmDict::Refine::Internal::StringRefineInternal

      def initialize(extract_proc)
        @extract_proc = extract_proc
      end

      private
      def extract_multiple_data(key, sep)
        extract_content_data(key).split(sep)
      end

      def extract_content_data(key)
        @extract_proc.call(key).dcm_unspace
      end
    end
  end
end
