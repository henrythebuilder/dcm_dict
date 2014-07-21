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
  module SourceData
    module DetachedData
      using DcmDict::ArrayRefine
      def self.make_group_length_data(tag)
        group = tag.group_str
        base_data = { :tag_ps =>  "(#{group},0000)",
                      :tag_name => "Group Length",
                      :tag_key =>  "GroupLength",
                      :tag_vr =>  [:UL],
                      :tag_vm =>  ['1'],
                      :tag_note =>  'Dummy Record'}
        RawData.new(base_data).data_element_record_data
      end
      def self.make_private_creator_data(tag)
        base_data = { :tag_ps =>  tag.tag_str,
                      :tag_name => "Private Creator",
                      :tag_key =>  "PrivateCreator",
                      :tag_vr =>  [:LO],
                      :tag_vm =>  ['1'],
                      :tag_note =>  'Dummy Record'}
        RawData.new(base_data).data_element_record_data
      end

      def self.make_unknown_data(tag)
        base_data = { :tag_ps =>  tag.tag_str,
                      :tag_name => "Unknown Tag",
                      :tag_key =>  "UnknownTag",
                      :tag_vr =>  [:UN],
                      :tag_vm =>  ['1'],
                      :tag_note =>  'Dummy Record'}
        RawData.new(base_data).data_element_record_data
      end

    end
  end
end
