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
  module Xml
    module NokogiriTool
      def self.tag_field_extract_proc(node_set)
        node_set_idx = { tag_ps: 0,
                         tag_name: 1,
                         tag_key: 2,
                         tag_vr: 3,
                         tag_vm: 4,
                         tag_note: 5 }
        Proc.new do |key|
          idx = node_set_idx[key]
          node_set[idx] ? node_set[idx].content : ''
        end
      end

      def self.uid_field_extract_proc(node_set)
        node_set_idx = { uid_value: 0,
                         uid_name: 1,
                         uid_type: 2}
        Proc.new do |key|
          idx = node_set_idx[key]
          node_set[idx] ? node_set[idx].content : ''
        end

      end
    end
  end
end
