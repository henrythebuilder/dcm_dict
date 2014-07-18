# coding: utf-8

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
  module XmlSampleSpecHelper
    def self.xml_single_set
      xml_string1=<<END
        <tr valign="top">
          <td align="center" colspan="1" rowspan="1">
            <para>
              <emphasis role="italic">(0008,0010)</emphasis>
            </para>
          </td>
          <td align="left" colspan="1" rowspan="1">
            <para>
              <emphasis role="italic">Recognition Code</emphasis>
            </para>
          </td>
          <td align="left" colspan="1" rowspan="1">
            <para>
              <emphasis role="italic">Recognition​Code</emphasis>
            </para>
          </td>
          <td align="center" colspan="1" rowspan="1">
            <para>
              <emphasis role="italic">SH</emphasis>
            </para>
          </td>
          <td align="center" colspan="1" rowspan="1">
            <para>
              <emphasis role="italic">1</emphasis>
            </para>
          </td>
          <td align="center" colspan="1" rowspan="1">
            <para>
              <emphasis role="italic">RET</emphasis>
            </para>
          </td>
        </tr>
END
      xml_string2 = <<END
        <tr valign="top">
          <td align="center" colspan="1" rowspan="1">
            <para>(0008,0012)</para>
          </td>
          <td align="left" colspan="1" rowspan="1">
            <para>Instance Creation Date</para>
          </td>
          <td align="left" colspan="1" rowspan="1">
            <para>Instance​Creation​Date</para>
          </td>
          <td align="center" colspan="1" rowspan="1">
            <para>DA</para>
          </td>
          <td align="center" colspan="1" rowspan="1">
            <para>1</para>
          </td>
          <td align="center" colspan="1" rowspan="1">
            <para/>
          </td>
        </tr>
END
      xml_string3 = <<END
        <tr valign="top">
          <td align="center" colspan="1" rowspan="1">
            <para>(0014,3050)</para>
          </td>
          <td align="left" colspan="1" rowspan="1">
            <para>Dark Current Counts</para>
          </td>
          <td align="left" colspan="1" rowspan="1">
            <para>Dark​Current​Counts</para>
          </td>
          <td align="center" colspan="1" rowspan="1">
            <para>OB or OW</para>
          </td>
          <td align="center" colspan="1" rowspan="1">
            <para>1</para>
          </td>
          <td align="center" colspan="1" rowspan="1">
            <para>DICONDE</para>
          </td>
        </tr>
END
      xml_string4 = <<END
<tr valign="top">
          <td align="center" colspan="1" rowspan="1">
            <para>(FFFE,E000)</para>
          </td>
          <td align="left" colspan="1" rowspan="1">
            <para>Item</para>
          </td>
          <td align="left" colspan="1" rowspan="1">
            <para>Item</para>
          </td>
          <td align="center" colspan="1" rowspan="1">
            <para>See Note <xref linkend="note_6_2"/></para>
          </td>
          <td align="center" colspan="1" rowspan="1">
            <para>1</para>
          </td>
          <td align="center" colspan="1" rowspan="1">
            <para/>
          </td>
        </tr>
END
      xml_string5 = <<END
        <tr valign="top">
          <td align="center" colspan="1" rowspan="1">
            <para>
              <emphasis role="italic">(0028,1200)</emphasis>
            </para>
          </td>
          <td align="left" colspan="1" rowspan="1">
            <para>
              <emphasis role="italic">Gray Lookup Table Data</emphasis>
            </para>
          </td>
          <td align="left" colspan="1" rowspan="1">
            <para>
              <emphasis role="italic">Gray​Lookup​Table​Data</emphasis>
            </para>
          </td>
          <td align="center" colspan="1" rowspan="1">
            <para>
              <emphasis role="italic">US or SS or OW</emphasis>
            </para>
          </td>
          <td align="center" colspan="1" rowspan="1">
            <para>
              <emphasis role="italic">1-n or 1</emphasis>
            </para>
          </td>
          <td align="center" colspan="1" rowspan="1">
            <para>
              <emphasis role="italic">RET</emphasis>
            </para>
          </td>
        </tr>
END

      {xml_string5 => {tag_str: '(0028,1200)',
                       tag_ary: [0x0028,0x1200],
                       tag_sym: :gray_lookup_table_data,
                       tag_num: '00281200',
                       tag_name: 'Gray Lookup Table Data',
                       tag_key: 'GrayLookupTableData',
                       tag_vr: [:US, :SS, :OW],
                       tag_vm: ['1-n', '1'],
                       tag_note: 'RET'},
       xml_string3 => {tag_str: '(0014,3050)',
                       tag_ary: [0x0014,0x3050],
                       tag_sym: :dark_current_counts,
                       tag_num: '00143050',
                       tag_name: 'Dark Current Counts',
                       tag_key: 'DarkCurrentCounts',
                       tag_vr: [:OB, :OW],
                       tag_vm: ['1'],
                       tag_note: 'DICONDE'},
       xml_string2 => {tag_str: '(0008,0012)',
                       tag_ary: [0x0008,0x0012],
                       tag_sym: :instance_creation_date,
                       tag_num: '00080012',
                       tag_name: 'Instance Creation Date',
                       tag_key: 'InstanceCreationDate',
                       tag_vr: [:DA],
                       tag_vm: ['1'],
                       tag_note: ''},
       xml_string1 => {tag_str: '(0008,0010)',
                       tag_ary: [0x0008,0x0010],
                       tag_sym: :recognition_code,
                       tag_num: '00080010',
                       tag_name: 'Recognition Code',
                       tag_key: 'RecognitionCode',
                       tag_vr: [:SH],
                       tag_vm: ['1'],
                       tag_note: 'RET'},
        xml_string4 => {tag_str: '(FFFE,E000)',
                        tag_ary: [0xfffe,0xe000],
                        tag_sym: :item,
                        tag_num: 'FFFEE000',
                        tag_name: 'Item',
                        tag_key: 'Item',
                        tag_vr: [:"See Note"],
                        tag_vm: ['1'],
                        tag_note: ''}}
    end

    def self.string_to_nodeset(xml_string)
      xml_doc  = Nokogiri::XML(xml_string)
      tr = xml_doc.xpath('//tr')
      tr[0].xpath('td')
    end
  end
end
