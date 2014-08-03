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
  module XML

    module RexmlTool
      def self.tag_field_extract_proc(node_set)
        make_rexml_proc(node_set, DataElementNodeSetIdx)
      end

      def self.uid_field_extract_proc(node_set)
        make_rexml_proc(node_set, UidNodeSetIdx)
      end

      private
      def self.make_rexml_proc(node_set, node_set_idx)
        Proc.new do |key|
          element = node_set[node_set_idx[key]]
          field = ''
          if element
            element.each_element_with_text do |txt1|
              field << "\n"  unless field.nil_or_empty?
              txt1.each_element_with_text do |txt2|
                field << txt2.texts.map(&:value).join('')
              end
              field << txt1.texts.map(&:value).join('')
            end
          end
          field
        end
      end
    end

  end
end
