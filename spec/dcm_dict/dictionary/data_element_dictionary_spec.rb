#
#  Copyright (C) 2014-2022  Enrico Rivarola
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
require 'data_element_sample_spec_helper'

describe DcmDict::Dictionary::DataElementDictionary do

  include_examples "Map all source data",
                   [:tag_ps, :tag_name, :tag_key, :tag_str, :tag_sym, :tag_ndm, :tag_ary],
                   DcmDict::SourceData::DataElementsData,
                   DcmDict::Dictionary::TheDataElementDictionary,
                   DcmDict::Dictionary::DataElementRecord,
                   [:tag_ps, :tag_name, :tag_key, :tag_vr, :tag_vm, :tag_str, :tag_sym,
                    :tag_ndm, :tag_ary, :tag_multiple, :tag_note]

  DataElementSampleSpecHelper.unknown_group_length_sample.
    merge(DataElementSampleSpecHelper.known_group_length_sample).
    merge(DataElementSampleSpecHelper.private_creator_sample).
    merge(DataElementSampleSpecHelper.standard_sample).
    merge(DataElementSampleSpecHelper.unknown_sample).each do |tag, data|
    include_examples "Handle specific record", "single tag",
                     tag, data, DcmDict::Dictionary::TheDataElementDictionary
  end

  DataElementSampleSpecHelper.multiple_tag_sample.each do |tag, data|
    include_examples "Handle specific record", "multiple tag",
                     tag, data, DcmDict::Dictionary::TheDataElementDictionary
  end

  [nil,
   123455,
   'abracadabra',
   Time.now,
   [1234.5678, 1234]
  ].each do |wrong_tag|
    include_examples "Dictionary with wrong key",
                     wrong_tag,
                     [:tag_ps, :tag_name, :tag_key, :tag_vr, :tag_vm, :tag_str,
                      :tag_sym, :tag_ndm, :tag_ary, :tag_multiple, :tag_note],
                     DcmDict::Dictionary::TheDataElementDictionary
  end

  include_examples "Dictionary Data not modifiable",
                   '(0002,0010)', :tag_ps, DcmDict::Dictionary::TheDataElementDictionary

  include_examples "Concurrency support",
                   '(0002,0010)',
                   DcmDict::Dictionary::TheDataElementDictionary,
                   { tag_ps: '(0002,0010)', tag_name: "Transfer Syntax UID",
                     tag_key: 'TransferSyntaxUID', tag_vr: [:UI], tag_vm: ["1"],
                     tag_str: '(0002,0010)', tag_sym: :transfer_syntax_uid,
                     tag_ndm: '00020010', tag_ary: [0x0002,0x0010],
                     tag_multiple: false, tag_note: ''}

end
