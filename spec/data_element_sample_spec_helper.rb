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
require 'spec_helper'
module DataElementSampleSpecHelper
  def self.private_creator_sample
    {
      [17,5] => {tag_ps: '(0011,0005)', tag_str: '(0011,0005)', tag_ary: [0x0011,0x0005],
                 tag_sym: :private_creator, tag_ndm: '00110005', tag_name: 'Private Creator',
                 tag_key: 'PrivateCreator', tag_vr: [:LO], tag_vm: ['1'], tag_note: 'Dummy Record',
                 tag_multiple: false},
      '(0011,0005)' => {tag_ps: '(0011,0005)', tag_str: '(0011,0005)', tag_ary: [0x0011,0x0005],
                 tag_sym: :private_creator, tag_ndm: '00110005', tag_name: 'Private Creator',
                 tag_key: 'PrivateCreator', tag_vr: [:LO], tag_vm: ['1'], tag_note: 'Dummy Record',
                 tag_multiple: false},
      '00110005' => {tag_ps: '(0011,0005)', tag_str: '(0011,0005)', tag_ary: [0x0011,0x0005],
                 tag_sym: :private_creator, tag_ndm: '00110005', tag_name: 'Private Creator',
                 tag_key: 'PrivateCreator', tag_vr: [:LO], tag_vm: ['1'], tag_note: 'Dummy Record',
                 tag_multiple: false}
    }
  end

  def self.unknown_sample
    {
      [17,512] => {tag_ps: '(0011,0200)', tag_str: '(0011,0200)', tag_ary: [0x0011,0x0200],
                   tag_sym: :unknown_tag, tag_ndm: '00110200', tag_name: 'Unknown Tag',
                   tag_key: 'UnknownTag', tag_vr: [:UN], tag_vm: ['1'], tag_note: 'Dummy Record', tag_multiple: false},
      [0x4444,0x1234] => {tag_ps: '(4444,1234)', tag_str: '(4444,1234)', tag_ary: [0x4444,0x1234],
                   tag_sym: :unknown_tag, tag_ndm: '44441234', tag_name: 'Unknown Tag',
                   tag_key: 'UnknownTag', tag_vr: [:UN], tag_vm: ['1'], tag_note: 'Dummy Record', tag_multiple: false},
      '(4444,1234)' => {tag_ps: '(4444,1234)', tag_str: '(4444,1234)', tag_ary: [0x4444,0x1234],
                   tag_sym: :unknown_tag, tag_ndm: '44441234', tag_name: 'Unknown Tag',
                   tag_key: 'UnknownTag', tag_vr: [:UN], tag_vm: ['1'], tag_note: 'Dummy Record', tag_multiple: false},
      '44441234' => {tag_ps: '(4444,1234)', tag_str: '(4444,1234)', tag_ary: [0x4444,0x1234],
                   tag_sym: :unknown_tag, tag_ndm: '44441234', tag_name: 'Unknown Tag',
                   tag_key: 'UnknownTag', tag_vr: [:UN], tag_vm: ['1'], tag_note: 'Dummy Record', tag_multiple: false},
    }
  end

  def self.known_group_length_sample
    {
      [0,0] => { tag_ps: '(0000,0000)', tag_name: "Command Group Length", tag_key: 'CommandGroupLength',
               tag_vr: [:UL], tag_vm: ["1"], tag_str: '(0000,0000)', tag_sym: :command_group_length,
               tag_ndm: '00000000', tag_ary: [0, 0], tag_multiple: false,
               tag_note: 'The even number of bytes from the end of the value field to the beginning of the next group.'}
    }
  end

  def self.unknown_group_length_sample
    {
      [16,0] => {tag_ps: '(0010,0000)', tag_str: '(0010,0000)', tag_ary: [0x0010,0x0000],
                 tag_sym: :group_length, tag_ndm: '00100000', tag_name: 'Group Length',
                 tag_key: 'GroupLength', tag_vr: [:UL], tag_vm: ['1'], tag_note: 'Dummy Record',
                 tag_multiple: false},
      [17,0] =>  {tag_ps: '(0011,0000)', tag_str: '(0011,0000)', tag_ary: [0x0011,0x0000],
                  tag_sym: :group_length, tag_ndm: '00110000', tag_name: 'Group Length',
                  tag_key: 'GroupLength', tag_vr: [:UL], tag_vm: ['1'], tag_note: 'Dummy Record',},
      [0x4444,0x0000] => {tag_ps: '(4444,0000)', tag_str: '(4444,0000)', tag_ary: [0x4444,0x0000],
                          tag_sym: :group_length, tag_ndm: '44440000', tag_name: 'Group Length',
                          tag_key: 'GroupLength', tag_vr: [:UL], tag_vm: ['1'], tag_note: 'Dummy Record',
                          tag_multiple: false},
      '44440000' => {tag_ps: '(4444,0000)', tag_str: '(4444,0000)', tag_ary: [0x4444,0x0000],
                          tag_sym: :group_length, tag_ndm: '44440000', tag_name: 'Group Length',
                          tag_key: 'GroupLength', tag_vr: [:UL], tag_vm: ['1'], tag_note: 'Dummy Record',
                          tag_multiple: false},
      '(4444,0000)' => {tag_ps: '(4444,0000)', tag_str: '(4444,0000)', tag_ary: [0x4444,0x0000],
                          tag_sym: :group_length, tag_ndm: '44440000', tag_name: 'Group Length',
                          tag_key: 'GroupLength', tag_vr: [:UL], tag_vm: ['1'], tag_note: 'Dummy Record',
                          tag_multiple: false}

    }
  end

  def self.multiple_tag_sample
    {
      # (60xx,0010) -> "Overlay Rows"
      [0x60A2,0x0010] => { tag_ps: '(60XX,0010)', tag_name: "Overlay Rows", tag_key: 'OverlayRows', tag_vr: [:US], tag_vm: ["1"], tag_str: '(60A2,0010)', tag_sym: :overlay_rows, tag_ndm: '60A20010', tag_ary: [0x60a2,0x0010], tag_multiple: true, tag_note: ''},
      '60A20010' => { tag_ps: '(60XX,0010)', tag_name: "Overlay Rows", tag_key: 'OverlayRows', tag_vr: [:US], tag_vm: ["1"], tag_str: '(60A2,0010)', tag_sym: :overlay_rows, tag_ndm: '60A20010', tag_ary: [0x60a2,0x0010], tag_multiple: true, tag_note: ''},
      '(60A2,0010)' => { tag_ps: '(60XX,0010)', tag_name: "Overlay Rows", tag_key: 'OverlayRows', tag_vr: [:US], tag_vm: ["1"], tag_str: '(60A2,0010)', tag_sym: :overlay_rows, tag_ndm: '60A20010', tag_ary: [0x60a2,0x0010], tag_multiple: true, tag_note: ''},
      '(6022,0010)' => { tag_ps: '(60XX,0010)', tag_name: "Overlay Rows", tag_key: 'OverlayRows', tag_vr: [:US], tag_vm: ["1"], tag_str: '(6022,0010)', tag_sym: :overlay_rows, tag_ndm: '60220010', tag_ary: [24610, 16], tag_multiple: true, tag_note: ''},
      'OverlayRows' => { tag_ps: '(60XX,0010)', tag_name: "Overlay Rows", tag_key: 'OverlayRows', tag_vr: [:US], tag_vm: ["1"], tag_str: '(6022,0010)', tag_sym: :overlay_rows, tag_ndm: '60220010', tag_ary: [24610, 16], tag_multiple: true, tag_note: ''},
      [0x6022,0x0010] => { tag_ps: '(60XX,0010)', tag_name: "Overlay Rows", tag_key: 'OverlayRows', tag_vr: [:US], tag_vm: ["1"], tag_str: '(6022,0010)', tag_sym: :overlay_rows, tag_ndm: '60220010', tag_ary: [24610, 16], tag_multiple: true, tag_note: ''},
      [0x1010,0xa1b2] => { tag_ps: '(1010,XXXX)', tag_name: "Zonal Map", tag_key: 'ZonalMap', tag_vr: [:US], tag_vm: ["1-n"], tag_str: '(1010,A1B2)', tag_sym: :zonal_map, tag_ndm: '1010A1B2', tag_ary: [0x1010, 0xa1b2], tag_multiple: true, tag_note: 'RET'},
      '(1010,A1B2)' => { tag_ps: '(1010,XXXX)', tag_name: "Zonal Map", tag_key: 'ZonalMap', tag_vr: [:US], tag_vm: ["1-n"], tag_str: '(1010,A1B2)', tag_sym: :zonal_map, tag_ndm: '1010A1B2', tag_ary: [0x1010, 0xa1b2], tag_multiple: true, tag_note: 'RET'},
      '1010A1B2' => { tag_ps: '(1010,XXXX)', tag_name: "Zonal Map", tag_key: 'ZonalMap', tag_vr: [:US], tag_vm: ["1-n"], tag_str: '(1010,A1B2)', tag_sym: :zonal_map, tag_ndm: '1010A1B2', tag_ary: [0x1010, 0xa1b2], tag_multiple: true, tag_note: 'RET'},
      '10100000' => { tag_ps: '(1010,0000)', tag_name: 'Group Length', tag_key: 'GroupLength', tag_vr: [:UL], tag_vm: ["1"], tag_str: '(1010,0000)', tag_sym: :group_length, tag_ndm: '10100000', tag_ary: [0x1010, 0x0000], tag_multiple: false, tag_note: 'Dummy Record'},
    }
  end

end
