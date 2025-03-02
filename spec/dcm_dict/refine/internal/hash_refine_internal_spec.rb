#
#  Copyright (C) 2014-2025  Enrico Rivarola
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

describe "Hash internal refinement" do
  using DcmDict::Refine::Internal::HashRefineInternal

  {
    '1.2.3.4.5.6' =>  { :uid_value => '1.2.3.4.5.6',
                        :uid_name  => '1.2.3.4.5.6 (Unknown UID)',
                        :uid_type  => :unknown,
                        :uid_key   => 'UID_1_2_3_4_5_6',
                        :uid_sym   => :uid_1_2_3_4_5_6,
                      }
  }.each do |uid_ref, expected_data|
    it "should check base uid fields for '#{uid_ref}" do
      data = {uid_value: uid_ref}
      data.check_base_data_uid_field!
      expect(data).to eq(expected_data)
    end

  end



  it "should check for lowercase tag_ps field" do
    h = {tag_ps: '(fffe,E000)'}
    h.check_tag_ps!
    expect(h).to eq({tag_ps: '(FFFE,E000)'})
  end

  it "should check for missing tag_ps field" do
    expect{ {tag_ps: ''}.check_tag_ps! }.to raise_error("Missing tag_ps field")
    expect{ {}.check_tag_ps! }.to raise_error("Missing tag_ps field")
  end

  context "Placeholders data: no Name or Keyword or VR or VM is specified" do
    {
      { tag_ps: '(0018,9445)', tag_name: '', tag_key: '', tag_vr: [], tag_vm: [], tag_note: 'RET - See Note' } => { tag_ps: '(0018,9445)', tag_name: "Placeholder (0018,9445)", tag_key: 'Placeholder_0018_9445', tag_vr: [:UN], tag_vm: ["1"], tag_note: 'RET - See Note'},
      { tag_ps: '(0018,9445)', tag_name: '', tag_key: '', tag_vm: [], tag_note: 'RET - See Note' } => { tag_ps: '(0018,9445)', tag_name: "Placeholder (0018,9445)", tag_key: 'Placeholder_0018_9445', tag_vr: [:UN], tag_vm: ["1"], tag_note: 'RET - See Note'},
      { tag_ps: '(0018,9445)', tag_name: '', tag_key: '', tag_vr: [], tag_note: 'RET - See Note' } => { tag_ps: '(0018,9445)', tag_name: "Placeholder (0018,9445)", tag_key: 'Placeholder_0018_9445', tag_vr: [:UN], tag_vm: ["1"], tag_note: 'RET - See Note'},
      { tag_ps: '(0018,9445)', tag_key: '', tag_vr: [], tag_vm: [], tag_note: 'RET - See Note' } => { tag_ps: '(0018,9445)', tag_name: "Placeholder (0018,9445)", tag_key: 'Placeholder_0018_9445', tag_vr: [:UN], tag_vm: ["1"], tag_note: 'RET - See Note'},
      { tag_ps: '(0018,9445)', tag_name: '', tag_vr: [], tag_vm: [], tag_note: 'RET - See Note' } => { tag_ps: '(0018,9445)', tag_name: "Placeholder (0018,9445)", tag_key: 'Placeholder_0018_9445', tag_vr: [:UN], tag_vm: ["1"], tag_note: 'RET - See Note'},
    }.each do |src_data, expected_data|
      it "should check for placeholder data (#{src_data[:tag_ps].inspect} with keys #{src_data.keys.inspect})" do
        src_data.check_placeholder_data!
        expect(src_data).to eq(expected_data)
      end
    end

    [
      { tag_ps: '', tag_name: '', tag_key: '', tag_vr: [], tag_vm: [], tag_note: 'RET - See Note' },
      { tag_name: '', tag_key: '', tag_vr: [], tag_vm: [], tag_note: 'RET - See Note' }
    ].each do |data|
      it "should raise error if :tag_ps field is missing (tag_ps=#{data[:tag_ps].inspect})" do
        expect{data.check_placeholder_data!}.to raise_error("Missing tag_ps field")
      end
    end

  end
end
