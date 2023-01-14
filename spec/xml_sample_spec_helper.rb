# coding: utf-8
#
#  Copyright (C) 2014-2023  Enrico Rivarola
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
module XmlSampleSpecHelper
  def self.xml_tag_sample_standard
    xml_string=<<END
<book xmlns="http://docbook.org/ns/docbook">
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
</book>
END
    data = {tag_ps: '(0008,0010)',
            tag_str: '(0008,0010)',
            tag_ary: [0x0008,0x0010],
            tag_sym: :recognition_code,
            tag_ndm: '00080010',
            tag_name: 'Recognition Code',
            tag_key: 'RecognitionCode',
            tag_vr: [:SH],
            tag_vm: ['1'],
            tag_note: 'RET',
            tag_multiple: false}
    {xml_string => data}
  end

  def self.xml_tag_sample_standard_empty_note
    xml_string = <<END
<book xmlns="http://docbook.org/ns/docbook">
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
</book>
END
    data = {tag_ps: '(0008,0012)',
            tag_str: '(0008,0012)',
            tag_ary: [0x0008,0x0012],
            tag_sym: :instance_creation_date,
            tag_ndm: '00080012',
            tag_name: 'Instance Creation Date',
            tag_key: 'InstanceCreationDate',
            tag_vr: [:DA],
            tag_vm: ['1'],
            tag_note: '',
            tag_multiple: false}
    {xml_string => data}
  end

  def self.xml_tag_sample_multiple_tag
    xml_string=<<END
<book xmlns="http://docbook.org/ns/docbook">
        <tr valign="top">
          <td align="center" colspan="1" rowspan="1">
            <para>(60xx,0040)</para>
          </td>
          <td align="left" colspan="1" rowspan="1">
            <para>Overlay Type</para>
          </td>
          <td align="left" colspan="1" rowspan="1">
            <para>Overlay​Type</para>
          </td>
          <td align="center" colspan="1" rowspan="1">
            <para>CS</para>
          </td>
          <td align="center" colspan="1" rowspan="1">
            <para>1</para>
          </td>
          <td align="center" colspan="1" rowspan="1">
            <para/>
          </td>
        </tr>
</book>
END

    data = {tag_ps: '(60XX,0040)',
            tag_str: '(6022,0040)',
            tag_ary: [0x6022,0x0040],
            tag_sym: :overlay_type,
            tag_ndm: '60220040',
            tag_name: 'Overlay Type',
            tag_key: 'OverlayType',
            tag_vr: [:CS],
            tag_vm: ['1'],
            tag_note: '',
            tag_multiple: true}
    {xml_string => data}
  end

  def self.xml_tag_sample_no_note
    xml_string=<<END
<book xmlns="http://docbook.org/ns/docbook">
       <tr valign="top">
          <td align="center" colspan="1" rowspan="1">
            <para>(0018,1202)</para>
          </td>
          <td align="left" colspan="1" rowspan="1">
            <para>DateTime of Last Calibration</para>
          </td>
          <td align="left" colspan="1" rowspan="1">
            <para>Date​Time​Of​Last​Calibration</para>
          </td>
          <td align="left" colspan="1" rowspan="1">
            <para>DT</para>
          </td>
          <td align="left" colspan="1" rowspan="1">
            <para>1</para>
          </td>
        </tr>
</book>
END
    data = {tag_ps: '(0018,1202)',
            tag_str: '(0018,1202)',
            tag_ary: [0x0018,0x1202],
            tag_sym: :date_time_of_last_calibration,
            tag_ndm: '00181202',
            tag_name: 'DateTime of Last Calibration',
            tag_key: 'DateTimeOfLastCalibration',
            tag_vr: [:DT],
            tag_vm: ['1'],
            tag_note: '',
            tag_multiple: false}
    {xml_string => data}
  end

  def self.xml_tag_sample_multi_vr_vm
    xml_string = <<END
<book xmlns="http://docbook.org/ns/docbook">
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
</book>
END
    data = {tag_ps: '(0028,1200)',
            tag_str: '(0028,1200)',
            tag_ary: [0x0028,0x1200],
            tag_sym: :gray_lookup_table_data,
            tag_ndm: '00281200',
            tag_name: 'Gray Lookup Table Data',
            tag_key: 'GrayLookupTableData',
            tag_vr: [:US, :SS, :OW],
            tag_vm: ['1-n', '1'],
            tag_note: 'RET',
            tag_multiple: false}
    {xml_string => data}
  end

  def self.xml_tag_sample_no_vr
    xml_string = <<END
<book xmlns="http://docbook.org/ns/docbook">
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
</book>
END
    data = {tag_ps: '(FFFE,E000)',
            tag_str: '(FFFE,E000)',
            tag_ary: [0xfffe,0xe000],
            tag_sym: :item,
            tag_ndm: 'FFFEE000',
            tag_name: 'Item',
            tag_key: 'Item',
            tag_vr: [:"See Note"],
            tag_vm: ['1'],
            tag_note: '',
            tag_multiple: false}
    {xml_string => data}
  end

  def self.xml_tag_sample_multi_vr
    xml_string = <<END
<book xmlns="http://docbook.org/ns/docbook">
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
</book>
END
    data = {tag_ps: '(0014,3050)',
            tag_str: '(0014,3050)',
            tag_ary: [0x0014,0x3050],
            tag_sym: :dark_current_counts,
            tag_ndm: '00143050',
            tag_name: 'Dark Current Counts',
            tag_key: 'DarkCurrentCounts',
            tag_vr: [:OB, :OW],
            tag_vm: ['1'],
            tag_note: 'DICONDE',
            tag_multiple: false}
    {xml_string => data}
  end

  def self.xml_tag_sample_empty
    xml_string=<<END
<book xmlns="http://docbook.org/ns/docbook">
        <tr valign="top">
          <td align="center" colspan="1" rowspan="1">
            <para>
              <emphasis role="italic">(0018,9445)</emphasis>
            </para>
          </td>
          <td align="center" colspan="1" rowspan="1">
            <para/>
          </td>
          <td align="center" colspan="1" rowspan="1">
            <para/>
          </td>
          <td align="center" colspan="1" rowspan="1">
            <para/>
          </td>
          <td align="center" colspan="1" rowspan="1">
            <para/>
          </td>
          <td align="center" colspan="1" rowspan="1">
            <para>
              <emphasis role="italic">RET - See Note <xref linkend="note_6_3"/></emphasis>
            </para>
          </td>
        </tr>
</book>
END
    data = {tag_ps: '(0018,9445)',
            tag_str: '(0018,9445)',
            tag_ary: [0x0018,0x9445],
            tag_sym: :placeholder_0018_9445,
            tag_ndm: '00189445',
            tag_name: 'Placeholder (0018,9445)',
            tag_key: 'Placeholder_0018_9445',
            tag_vr: [:UN],
            tag_vm: ['1'],
            tag_note: 'RET - See Note',
            tag_multiple: false}
    {xml_string => data}
  end

  def self.xml_tag_sample_lowercase_tag
    xml_string = <<END
<book xmlns="http://docbook.org/ns/docbook">
        <tr valign="top">
          <td align="center" colspan="1" rowspan="1">
            <para>(0074,100a)</para>
          </td>
          <td align="left" colspan="1" rowspan="1">
            <para>Contact URI</para>
          </td>
          <td align="left" colspan="1" rowspan="1">
            <para>ContactURI</para>
          </td>
          <td align="center" colspan="1" rowspan="1">
            <para>ST</para>
          </td>
          <td align="center" colspan="1" rowspan="1">
            <para>1</para>
          </td>
          <td align="center" colspan="1" rowspan="1">
            <para/>
          </td>
        </tr>
</book>
END
    data = {tag_ps: '(0074,100A)',
            tag_str: '(0074,100A)',
            tag_ary: [0x0074,0x100a],
            tag_sym: :contact_uri,
            tag_ndm: '0074100A',
            tag_name: 'Contact URI',
            tag_key: 'ContactURI',
            tag_vr: [:ST],
            tag_vm: ['1'],
            tag_note: '',
            tag_multiple: false}
    {xml_string => data}
  end

  def self.xml_tag_multiline_note_set
    xml_string = <<END
<book xmlns="http://docbook.org/ns/docbook">
    <tr valign="top">
      <td align="center" colspan="1" rowspan="1">
        <para>(0000,0700)</para>
      </td>
      <td align="left" colspan="1" rowspan="1">
        <para>Priority</para>
      </td>
      <td align="left" colspan="1" rowspan="1">
        <para>Priority</para>
      </td>
      <td align="center" colspan="1" rowspan="1">
        <para>US</para>
      </td>
      <td align="center" colspan="1" rowspan="1">
        <para>1</para>
      </td>
      <td align="left" colspan="1" rowspan="1">
        <para>The priority shall be set to one of the following values:</para>
        <para>LOW = 0002H</para>
        <para>MEDIUM = 0000H</para>
        <para>HIGH = 0001H</para>
      </td>
    </tr>
</book>
END
    note = <<NOTE.chop
The priority shall be set to one of the following values:
LOW = 0002H
MEDIUM = 0000H
HIGH = 0001H
NOTE
    data = {tag_ps: '(0000,0700)',
            tag_str: '(0000,0700)',
            tag_ary: [0x0000,0x0700],
            tag_sym: :priority,
            tag_ndm: '00000700',
            tag_name: 'Priority',
            tag_key: 'Priority',
            tag_vr: [:US],
            tag_vm: ['1'],
            tag_note: note,
            tag_multiple: false}
    {xml_string => data}
  end

  def self.xml_tag_complex_note
    xml_string= <<END
<book xmlns="http://docbook.org/ns/docbook">
    <tr valign="top">
      <td align="center" colspan="1" rowspan="1">
        <para>(0000,0900)</para>
      </td>
      <td align="left" colspan="1" rowspan="1">
        <para>Status</para>
      </td>
      <td align="left" colspan="1" rowspan="1">
        <para>Status</para>
      </td>
      <td align="center" colspan="1" rowspan="1">
        <para>US</para>
      </td>
      <td align="center" colspan="1" rowspan="1">
        <para>1</para>
      </td>
      <td align="left" colspan="1" rowspan="1">
        <para>Confirmation status of the operation. See <xref linkend="chapter_C" xrefstyle="template: Annex %n"/>.</para>
      </td>
    </tr>
</book>
END
    data = {tag_ps: '(0000,0900)',
            tag_str: '(0000,0900)',
            tag_ary: [0x0000,0x0900],
            tag_sym: :status,
            tag_ndm: '00000900',
            tag_name: 'Status',
            tag_key: 'Status',
            tag_vr: [:US],
            tag_vm: ['1'],
            tag_note: "Confirmation status of the operation. See .",
            tag_multiple: false}
    {xml_string => data}
  end

  def self.xml_tag_single_set
    { }.merge(xml_tag_sample_standard).
      merge(xml_tag_multiline_note_set).
      merge(xml_tag_sample_standard_empty_note).
      merge(xml_tag_complex_note).
      merge(xml_tag_sample_multiple_tag).
      merge(xml_tag_sample_no_note).
      merge(xml_tag_sample_multi_vr_vm).
      merge(xml_tag_sample_no_vr).
      merge(xml_tag_sample_multi_vr).
      merge(xml_tag_sample_empty).
      merge(xml_tag_sample_lowercase_tag)
  end

  def self.uid_single_standard
       xml_string=<<END
<book xmlns="http://docbook.org/ns/docbook">
<tr valign="top">
                    <td align="left" colspan="1" rowspan="1">
                        <para xml:id="para_893becfb-16cd-4300-923d-e422781af211">1.2.840.10008.1.​2</para>
                    </td>
                    <td align="left" colspan="1" rowspan="1">
                        <para xml:id="para_ccbbb435-5d2e-4d4d-b2c2-a27a5a762f75">Implicit VR Little Endian: Default Transfer Syntax for DICOM</para>
                    </td>
                    <td align="left" colspan="1" rowspan="1">
                        <para xml:id="para_6871172d-db56-4b45-b5d5-446f82a22c89">Implicit​VR​Little​Endian</para>
                    </td>
                    <td align="left" colspan="1" rowspan="1">
                        <para xml:id="para_6e075f3d-2392-4c57-908c-889b50ebcbcd">Transfer Syntax</para>
                    </td>
                    <td align="center" colspan="1" rowspan="1">
                        <para xml:id="para_c2a11bee-08cc-422f-a64c-01dcb4baf73b">
                            <olink targetdoc="PS3.5" targetptr="PS3.5" xrefstyle="select: labelnumber"/>
                        </para>
                    </td>
                </tr>
</book>
END
    data = {uid_value: "1.2.840.10008.1.2",
            uid_name: "Implicit VR Little Endian: Default Transfer Syntax for DICOM",
            uid_key: 'ImplicitVRLittleEndian',
            uid_sym: :implicit_vr_little_endian,
            uid_type: :transfer_syntax}
    {xml_string => data}
  end

  def self.uid_sample_retired_noname
    xml_string=<<END
<book xmlns="http://docbook.org/ns/docbook">
<tr valign="top">
                    <td align="left" colspan="1" rowspan="1">
                        <para xml:id="para_0b48f6f3-b2fe-49cf-a870-c6d3635f4266">
                            <emphasis role="italic">1.2.840.10008.​5.​1.​4.​1.​1.​12.​77</emphasis>
                        </para>
                    </td>
                    <td align="left" colspan="1" rowspan="1">
                        <para xml:id="para_6ca19788-eac9-4d90-b754-aaa06bebe9e9">
                            <emphasis role="italic">(Retired)</emphasis>
                        </para>
                    </td>
                    <td align="left" colspan="1" rowspan="1">
                        <para xml:id="para_336821ef-5d70-4332-9b88-f4704825ac91">
<emphasis role="italic"/>
</para>
                    </td>
                    <td align="left" colspan="1" rowspan="1">
                        <para xml:id="para_ca5d2e50-63ea-4008-80ae-896296e83fdd">
                            <emphasis role="italic">SOP Class</emphasis>
                        </para>
                    </td>
                    <td align="center" colspan="1" rowspan="1">
                        <para xml:id="para_178cccfe-86a2-41a1-b905-70e5fbc5eebf">
                            <emphasis role="italic">(2015c)</emphasis>
                        </para>
                    </td>
                </tr>
</book>
END
    data = {uid_value: "1.2.840.10008.5.1.4.1.1.12.77",
            uid_name: "1.2.840.10008.5.1.4.1.1.12.77 (Retired)",
            uid_key: 'UID_1_2_840_10008_5_1_4_1_1_12_77',
            uid_sym: :uid_1_2_840_10008_5_1_4_1_1_12_77,
            uid_type: :sop_class}
    {xml_string => data}
  end

  def self.uid_standard_sop
    xml_string=<<END
<book xmlns="http://docbook.org/ns/docbook">
<tr valign="top">
          <td align="left" colspan="1" rowspan="1">
            <para xml:id="para_de68fe97-b7cf-497e-af8f-a653669ac4e4">1.2.840.10008.1.​1</para>
          </td>
          <td align="left" colspan="1" rowspan="1">
            <para xml:id="para_935df29c-2e6c-4d50-aa93-83225337b0ba">Verification SOP Class</para>
          </td>
          <td align="left" colspan="1" rowspan="1">
            <para xml:id="para_5b280f39-109f-416f-bbc7-fb65409d9574">Verification</para>
          </td>
          <td align="left" colspan="1" rowspan="1">
            <para xml:id="para_5e8dcea9-7c49-4751-b561-ca8a41698555">SOP Class</para>
          </td>
          <td align="center" colspan="1" rowspan="1">
            <para xml:id="para_d37461b4-5537-4bf6-98b1-ded888b9b028">
               <olink targetdoc="PS3.4" targetptr="PS3.4" xrefstyle="select: labelnumber"/>
            </para>
          </td>
        </tr>

</book>
END
    data = {uid_value: "1.2.840.10008.1.1",
            uid_name: "Verification SOP Class",
            uid_key: 'Verification',
            uid_sym: :verification,
            uid_type: :sop_class}
    {xml_string => data}
  end

  def self.xml_uid_set
    {}.merge(uid_single_standard).
      merge(uid_sample_retired_noname).
      merge(uid_standard_sop)
  end

end
