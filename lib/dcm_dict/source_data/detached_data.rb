#
#  Copyright (C) 2014-2015  Enrico Rivarola
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
  module SourceData
    module DetachedData
      using DcmDict::Refine::Internal::ArrayRefineInternal
      using DcmDict::Refine::Internal::StringRefineInternal

      # Make group length data using +tag+
      def self.make_group_length_data(tag)
        make_detached_data({ :tag_ps =>  "(#{tag.tag_group_str},0000)",
                             :tag_name => 'Group Length',
                             :tag_key =>  'GroupLength',
                             :tag_vr =>  'UL',
                             :tag_vm =>  '1',
                             :tag_note =>  'Dummy Record'})
      end

      # Make private creator data using +tag+
      def self.make_private_creator_data(tag)
        make_detached_data({ :tag_ps =>  tag.to_tag_str,
                             :tag_name => 'Private Creator',
                             :tag_key =>  'PrivateCreator',
                             :tag_vr =>  'LO',
                             :tag_vm =>  '1',
                             :tag_note =>  'Dummy Record'})
      end

      # Make unknow data element data using +tag+
      def self.make_unknown_data(tag)
        make_detached_data({ :tag_ps =>  tag.to_tag_str,
                             :tag_name => 'Unknown Tag',
                             :tag_key =>  'UnknownTag',
                             :tag_vr =>  'UN',
                             :tag_vm =>  '1',
                             :tag_note =>  'Dummy Record'})
      end

      private
      def self.make_detached_data(base_data)
        DcmDict::XML::TagFieldData.new(Proc.new {|key| base_data[key]}).
          data_element_data
      end
    end
  end
end
