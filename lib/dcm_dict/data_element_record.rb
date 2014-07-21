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
  class DataElementRecord
    using DcmDict::StringRefineInternal
    using DcmDict::ArrayRefineInternal

    MethodsMap = {:multiple_tag? => :tag_multiple,
                  :name => :tag_name,
                  :keyword => :tag_key,
                  :vr => :tag_vr,
                  :vm => :tag_vm,
                  :note => :tag_note,
                  :tag_ary => :tag_ary,
                  :tag_ps => :tag_ps,
                  :tag_sym => :tag_sym,
                  :tag_ndm => :tag_ndm,
                  :tag_str => :tag_str
                 }

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
      tag_to_match = decompose_tag(tag)
      tag_pattern.each do |pattern|
        re = Regexp.new(pattern)
        return true if re.match(tag_to_match)
      end
      false
    end

    def method_missing(name, *args, &block)
      return @data[MethodsMap[name.to_sym]] if (MethodsMap.has_key?(name.to_sym))
      return @data[name.to_sym] if (@data.has_key?(name.to_sym))
      super
    end

    def make_specific_record(tag)
      ref_tag = tag.to_tag_ary
      DataElementRecord.new( @data.merge( { tag_str: ref_tag.to_tag_str,
                                            tag_ndm: ref_tag.to_tag_str.tag_str_to_digit_str,
                                            tag_ary: ref_tag }))
    end

    private
    def respond_to_missing?(name, include_priv)
      MethodsMap.has_key?(name) || @data.has_key?(name)
    end

    def decompose_tag(tag)
      tag.to_tag_str
    end

    def tag_pattern
      gs, es = self.tag_ps.gsub(/[\(|\)]/, '').gsub(/[xX]/,"[0-9A-Fa-f]").split(',')
      ["^\\(#{gs}\\,#{es}\\)$", "^#{gs}#{es}$" ]
    end

  end
end
