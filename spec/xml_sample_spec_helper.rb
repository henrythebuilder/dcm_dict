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
      {xml_string3 => {tag_str: '(0014,3050)',
                       tag_name: 'Dark Current Counts',
                       tag_key: 'DarkCurrentCounts',
                       tag_vr: 'OB or OW',
                       tag_vm: '1',
                       tag_note: 'DICONDE'},
        xml_string2 => {tag_str: '(0008,0012)',
                       tag_name: 'Instance Creation Date',
                       tag_key: 'InstanceCreationDate',
                       tag_vr: 'DA',
                       tag_vm: '1',
                       tag_note: ''},
       xml_string1 => {tag_str: '(0008,0010)',
                       tag_name: 'Recognition Code',
                       tag_key: 'RecognitionCode',
                       tag_vr: 'SH',
                       tag_vm: '1',
                       tag_note: 'RET'}}
    end

  end
end
