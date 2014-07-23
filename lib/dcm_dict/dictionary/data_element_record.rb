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
    DataElementMethodMap = {:multiple_tag? => :tag_multiple,
                             :name => :tag_name,
                             :keyword => :tag_key,
                             :vr => :tag_vr,
                             :vm => :tag_vm,
                             :note => :tag_note,
                             :tag => :tag_ary,
                             :tag_ary => :tag_ary,
                             :tag_ps => :tag_ps,
                             :tag_sym => :tag_sym,
                             :tag_ndm => :tag_ndm,
                             :tag_str => :tag_str }

    # Class to handle data element record from source dictionary data
    class DataElementRecord
      using DcmDict::Refine::Internal::StringRefineInternal
      using DcmDict::Refine::Internal::ArrayRefineInternal

      def initialize(data)
        @data = data
      end

      def group
        @data[:tag_ary].group
      end

      def element
        @data[:tag_ary].element
      end

      def match_tag?(tag)
        tag_to_match = tag.to_tag_str
        tag_pattern.each do |pattern|
          re = Regexp.new(pattern)
          return true if re.match(tag_to_match)
        end
        false
      end

      def method_missing(name, *args, &block)
        name_as_sym = name.to_sym
        return @data[DataElementMethodMap[name_as_sym]] if (DataElementMethodMap.has_key?(name_as_sym))
        return @data[name_as_sym] if (@data.has_key?(name_as_sym))
        super
      end

      def make_specific_record(tag)
        ref_tag = tag.to_tag_ary
        tag_str = ref_tag.to_tag_str
        DataElementRecord.new( @data.merge( { tag_str: tag_str,
                                              tag_ndm: tag_str.to_tag_ndm,
                                              tag_ary: ref_tag }))
      end

      private
      def respond_to_missing?(name, include_priv)
        DataElementMethodMap.has_key?(name) || @data.has_key?(name)
      end

      def tag_pattern
        gs, es = self.tag_ps.gsub(/[\(|\)]/, '').gsub(/[xX]/,"[0-9A-Fa-f]").split(',')
        ["^\\(#{gs}\\,#{es}\\)$", "^#{gs}#{es}$" ]
      end

    end
  end
end
