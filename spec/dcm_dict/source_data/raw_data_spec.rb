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
describe DcmDict::SourceData::RawData do
  [
    { #lowercase tag
      :source_data => {
        tag_ps: '(0074,100a)',
        tag_name: 'Contact URI',
        tag_key: 'ContactURI',
        tag_vr: [:ST],
        tag_vm: ['1'],
        tag_note: ''},
      :expected_data => {
        tag_ps: '(0074,100A)',
        tag_str: '(0074,100A)',
        tag_ary: [0x0074,0x100a],
        tag_sym: :contact_uri,
        tag_ndm: '0074100A',
        tag_name: 'Contact URI',
        tag_key: 'ContactURI',
        tag_vr: [:ST],
        tag_vm: ['1'],
        tag_note: '',
        tag_multiple: false}}
  ].each do |data|
    it "check source data" do
      record_data = DcmDict::SourceData::RawData.new(data[:source_data]).data_element_record_data
      data[:expected_data].each do |key, val|
        expect(record_data[key]).to eq(val)
      end
    end
  end

end
