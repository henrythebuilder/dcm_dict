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
require 'spec_helper'
require 'data_element_sample_spec_helper'

describe DcmDict::Dictionary::DataElementDictionary do
  it "should map all source data" do
    index_keys = [:tag_ps, :tag_name, :tag_key, :tag_str, :tag_sym, :tag_ndm, :tag_ary]
    DcmDict::SourceData::DataElementsData.each do |record|
      index_keys.each do |key|
        obj = DcmDict::Dictionary::TheDataElementDictionary.record_at(record[key])
        expect(obj).not_to be_nil, "#{key.inspect} > #{record[:tag_ps]}"
        expect(obj).to be_a(DcmDict::Dictionary::DataElementRecord)
        expect(obj).to be_frozen
        [:tag_ps, :tag_name, :tag_key, :tag_vr, :tag_vm, :tag_str, :tag_sym, :tag_ndm, :tag_ary, :tag_multiple, :tag_note].each do |field|
          feature = DcmDict::Dictionary::TheDataElementDictionary.
                    feature_at(record[key], field)
          expect(feature).to eq(record[field])
        end
      end
    end
  end

  DataElementSampleSpecHelper.unknown_group_length_sample.
    merge(DataElementSampleSpecHelper.known_group_length_sample).
    merge(DataElementSampleSpecHelper.private_creator_sample).
    merge(DataElementSampleSpecHelper.unknown_sample).each do |tag, data|
    it "should handling special case for tag = #{tag.inspect}" do
      obj = DcmDict::Dictionary::TheDataElementDictionary.record_at(tag)
      expect(obj).not_to be_nil, "#{tag.inspect} not found into dictionary"
      data.each do |key, value|
        field = obj.send(key)
        expect(field).to eq(value)
        feature = DcmDict::Dictionary::TheDataElementDictionary.feature_at(tag, key)
        expect(feature).to eq(value)
      end
    end
  end

  DataElementSampleSpecHelper.multiple_tag_sample.each do |tag, data|
    it "should handling multiple tag (#{tag.inspect})" do
      obj = DcmDict::Dictionary::TheDataElementDictionary.record_at(tag)
      expect(obj).not_to be_nil, "#{tag.inspect} not found into dictionary"
      data.each do |key, value|
        field = obj.send(key)
        expect(field).to eq(value)
        feature = DcmDict::Dictionary::TheDataElementDictionary.feature_at(tag, key)
        expect(feature).to eq(value)
      end

    end
  end

  [nil,
   123455,
   'abracadabra',
   Time.now,
   [1234.5678, 1234]
  ].each do |wrong_tag|
    it "with wrong tag request as tag = #{wrong_tag.inspect}" do
      expect {DcmDict::Dictionary::TheDataElementDictionary.record_at(wrong_tag)}.
        to raise_error(DcmDict::DictionaryError)
      [:tag_ps, :tag_name, :tag_key, :tag_vr, :tag_vm, :tag_str, :tag_sym, :tag_ndm, :tag_ary, :tag_multiple, :tag_note].each do |field|
        expect { DcmDict::Dictionary::TheDataElementDictionary.
                 feature_at(wrong_tag, field) }.
          to raise_error(DcmDict::DictionaryError)
      end
    end
  end

  it "data should be not modifiable" do
    expect(DcmDict::Dictionary::TheDataElementDictionary).to be_frozen
    tag = '(0002,0010)'
    obj = DcmDict::Dictionary::TheDataElementDictionary.record_at(tag)
    expect{obj.tag_ps << 'aaa'}.to raise_error
    expect { DcmDict::Dictionary::TheDataElementDictionary.
             feature_at(tag, :tag_ps) << 'aaa' }.to raise_error
  end

  include_examples "Concurrency support",
                   '(0002,0010)',
                   DcmDict::Dictionary::TheDataElementDictionary,
                   { tag_ps: '(0002,0010)', tag_name: "Transfer Syntax UID",
                     tag_key: 'TransferSyntaxUID', tag_vr: [:UI], tag_vm: ["1"],
                     tag_str: '(0002,0010)', tag_sym: :transfer_syntax_uid,
                     tag_ndm: '00020010', tag_ary: [0x0002,0x0010],
                     tag_multiple: false, tag_note: ''}

end
