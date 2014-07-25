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
require 'spec_helper'



describe DcmDict::Dictionary::DataElementRecord do
  using DcmDict::Refine::Internal::ArrayRefineInternal

  [
    {tag_ps: '(0008,0010)',
     tag_name: 'Recognition Code',
     tag_key: 'RecognitionCode',
     tag_vr: [:SH],
     tag_vm: ['1'],
     tag_note: 'RET',
     tag_ary: [0x0008,0x0010],
     tag_sym: :recognition_code,
     tag_ndm: '00080010',
     tag_str: '(0008,0010)',
     tag_multiple: false
    },
  ].each do |data|
    it "Handle Data Element Data correctly" do
      der = DcmDict::Dictionary::DataElementRecord.new(data)
      expect(der.tag_ps).to eq(data[:tag_ps])
      expect(der.name).to eq(data[:tag_name])
      expect(der.keyword).to eq(data[:tag_key])
      expect(der.vr).to eq(data[:tag_vr])
      expect(der.vm).to eq(data[:tag_vm])
      expect(der.note).to eq(data[:tag_note])
      expect(der.tag_ary).to eq(data[:tag_ary])
      expect(der.tag_sym).to eq(data[:tag_sym])
      expect(der.tag_ndm).to eq(data[:tag_ndm])
      expect(der.tag_str).to eq(data[:tag_str])
      expect(der.multiple_tag?).to eq(data[:tag_multiple])

      data.each do |key, expected_val|
        expect(der.send(key)).to eq(expected_val)
      end

    end

    include_examples "Record handle methods correctly",
                     DcmDict::Dictionary::DataElementRecord.new(data),
                     data


    it "Handle group and element with explicit method" do
      der = DcmDict::Dictionary::DataElementRecord.new(data)
      expect(der.group).to eq(data[:tag_ary].group)
      expect(der.element).to eq(data[:tag_ary].element)
    end

  end

  {
    # { tag_ps: '(60xx,0010)', tag_name: "Overlay Rows", tag_key: 'OverlayRows', tag_vr: [:US], tag_vm: ["1"], tag_str: '(6022,0010)', tag_sym: :overlay_rows, tag_ndm: '60220010', tag_ary: [24610, 16], tag_multiple: true, tag_note: ''},
    [
      '(6068,0010)', '60680010', [0x6068,0x0010]
    ] => {
      :source_data => { tag_ps: '(60XX,0010)', tag_name: "Overlay Rows", tag_key: 'OverlayRows', tag_vr: [:US], tag_vm: ["1"], tag_str: '(6022,0010)', tag_sym: :overlay_rows, tag_ndm: '60220010', tag_ary: [24610, 16], tag_multiple: true, tag_note: ''},
      :specific_data => { tag_ps: '(60XX,0010)', tag_name: "Overlay Rows", tag_key: 'OverlayRows', tag_vr: [:US], tag_vm: ["1"], tag_str: '(6068,0010)', tag_sym: :overlay_rows, tag_ndm: '60680010', tag_ary: [0x6068,0x0010], tag_multiple: true, tag_note: ''} }
  }.each do |keys, multi_data|
    it "check match for multiple tag definition" do
      der = DcmDict::Dictionary::DataElementRecord.new(multi_data[:source_data])
      keys.each do |key|
        expect(der.match_tag?(key)).to be_truthy
      end

    end

    it "generate equivalent record for specific tag" do
      der_multi = DcmDict::Dictionary::DataElementRecord.new(multi_data[:source_data])
      der = der_multi.make_specific_record(multi_data[:specific_data][:tag_ary])
      multi_data[:specific_data].each do |key, val|
        expect(der.send(key)).to eq(val)
      end

    end
  end

end
