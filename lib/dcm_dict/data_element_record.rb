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
    using DcmDict::StringRefineXml

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

    def method_missing(name, *args, &block)
      return @data[MethodsMap[name.to_sym]] if (MethodsMap.has_key?(name.to_sym))
      return @data[name.to_sym] if (@data.has_key?(name.to_sym))
      super
    end

    private
    def respond_to_missing?(name, include_priv)
      MethodsMap.has_key?(name) || @data.has_key?(name)
    end

  end
end
