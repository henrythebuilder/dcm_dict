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

describe DcmDict::DataElementRecord do
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
      der = DcmDict::DataElementRecord.new(data)
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

    it "Handle methods correctly (by symbol)" do
      der = DcmDict::DataElementRecord.new(data)
      data.each do |key, expected_val|
        expect(der.respond_to?(key)).to be true
      end

      expect(der.respond_to?(:undefined_method_for_data_element_record)).to be false
      expect {der.undefined_method_for_data_element_record }.to raise_error(NoMethodError)
    end

    it "Handle methods correctly (by string)" do
      der = DcmDict::DataElementRecord.new(data)
      data.each do |key, expected_val|
        expect(der.respond_to?(key.to_s)).to be true
      end

      expect(der.respond_to?(:undefined_method_for_data_element_record.to_s)).to be false
      expect {der.undefined_method_for_data_element_record }.to raise_error(NoMethodError)
      expect {der.send("undefined_method_for_data_element_record") }.to raise_error(NoMethodError)
    end

  end

end
