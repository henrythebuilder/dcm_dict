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

    NodeSetIdx = { tag_ps: 0,
                   tag_name: 1,
                   tag_key: 2,
                   tag_vr: 3,
                   tag_vm: 4,
                   tag_note: 5 }

    MultiFieldSeparator = ' or '

    class NodeSetData
      using DcmDict::Refine::Internal::StringRefineInternal

      def initialize(extract_proc)
        @exproc = extract_proc
      end

      def data_element_data
        SourceData::RawData.new( extract_base_data ).
          data_element_record_data
      end

      private
      def extract_base_data()
        { :tag_ps =>  extract_tag_ps(),
          :tag_name =>  extract_tag_name(),
          :tag_key =>  extract_tag_key(),
          :tag_vr =>  extract_tag_vr(),
          :tag_vm =>  extract_tag_vm(),
          :tag_note => extract_tag_note() }
      end


      def extract_tag_ps()
        extract_content_data(:tag_ps)
      end

      def extract_tag_name()
        extract_content_data(:tag_name)
      end

      def extract_tag_key()
        extract_content_data(:tag_key)
      end

      def extract_tag_vr()
        extract_multiple_data(:tag_vr).map(&:to_sym)
      end

      def extract_tag_vm()
        extract_multiple_data(:tag_vm)
      end

      def extract_tag_note()
        extract_content_data(:tag_note)
      end


      def extract_multiple_data(key)
        extract_content_data(key).split(MultiFieldSeparator)
      end

      def extract_content_data(key)
        @exproc.call(key).dcm_unspace
      end

    end

  end
end
