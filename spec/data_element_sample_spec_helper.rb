# coding: utf-8
#
#  Copyright (C) 2014-2019  Enrico Rivarola
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

  def self.standard_sample
    {
      [0x0018, 0x9323] => { tag_ps: '(0018,9323)', tag_name: "Exposure Modulation Type", tag_key: 'ExposureModulationType',
                            tag_vr: [:CS], tag_vm: ["1-n"], tag_str: '(0018,9323)', tag_sym: :exposure_modulation_type,
                            tag_ndm: '00189323', tag_ary: [0x0018, 0x9323], tag_multiple: false,
                            tag_note: ''},
      [0x3006, 0x0033] => { tag_ps: '(3006,0033)', tag_name: "RT ROI Relationship", tag_key: 'RTROIRelationship',
                            tag_vr: [:CS], tag_vm: ["1"], tag_str: '(3006,0033)', tag_sym: :rt_roi_relationship,
                            tag_ndm: '30060033', tag_ary: [0x3006, 0x0033], tag_multiple: false,
                            tag_note: ''},
      [0x3006, 0x00B9] => { tag_ps: '(3006,00B9)', tag_name: "Additional RT ROI Identification Code Sequence", tag_key: 'AdditionalRTROIIdentificationCodeSequence',
                            tag_vr: [:SQ], tag_vm: ["1"], tag_str: '(3006,00B9)', tag_sym: :additional_rt_roi_identification_code_sequence,
                            tag_ndm: '300600B9', tag_ary: [0x3006, 0x00B9], tag_multiple: false,
                            tag_note: 'RET (2016c)'},
      [0x4010, 0x1019] => { tag_ps: '(4010,1019)', tag_name: "Z Effective", tag_key: 'ZEffective',
                            tag_vr: [:FL], tag_vm: ["1"], tag_str: '(4010,1019)', tag_sym: :z_effective,
                            tag_ndm: '40101019', tag_ary: [0x4010, 0x1019], tag_multiple: false,
                            tag_note: 'DICOS'},
      [0x300A, 0x0434] => { tag_ps: '(300A,0434)', tag_name: "Applicator Opening X", tag_key: 'ApplicatorOpeningX',
                            tag_vr: [:FL], tag_vm: ["1"], tag_str: '(300A,0434)', tag_sym: :applicator_opening_x,
                            tag_ndm: '300A0434', tag_ary: [0x300A, 0x0434], tag_multiple: false,
                            tag_note: ''},
      [0x3004, 0x0062] => { tag_ps: '(3004,0062)', tag_name: "DVH ROI Contribution Type", tag_key: 'DVHROIContributionType',
                            tag_vr: [:CS], tag_vm: ["1"], tag_str: '(3004,0062)', tag_sym: :dvh_roi_contribution_type,
                            tag_ndm: '30040062', tag_ary: [0x3004, 0x0062], tag_multiple: false,
                            tag_note: ''},
      [0x2020, 0x0140] => { tag_ps: '(2020,0140)', tag_name: "Referenced VOI LUT Box Sequence", tag_key: 'ReferencedVOILUTBoxSequence',
                            tag_vr: [:SQ], tag_vm: ["1"], tag_str: '(2020,0140)', tag_sym: :referenced_voi_lut_box_sequence,
                            tag_ndm: '20200140', tag_ary: [0x2020, 0x0140], tag_multiple: false,
                            tag_note: 'RET (1998)'},
      [0x0010, 0x1000] => { tag_ps: '(0010,1000)', tag_name: "Other Patient IDs", tag_key: 'OtherPatientIDs',
                            tag_vr: [:LO], tag_vm: ["1-n"], tag_str: '(0010,1000)', tag_sym: :other_patient_ids,
                            tag_ndm: '00101000', tag_ary: [0x0010,0x1000], tag_multiple: false,
                            tag_note: 'RET (2017a)'},
      [0x0018, 0x9504] => { tag_ps: '(0018,9504)', tag_name: "X-Ray 3D Frame Type Sequence", tag_key: 'XRay3DFrameTypeSequence',
                            tag_vr: [:SQ], tag_vm: ["1"], tag_str: '(0018,9504)', tag_sym: :x_ray_3d_frame_type_sequence,
                            tag_ndm: '00189504', tag_ary: [0x0018,0x9504], tag_multiple: false,
                            tag_note: ''},
      [0x0052,0x0030] => { tag_ps: '(0052,0030)', tag_name: "OCT Z Offset Correction", tag_key: 'OCTZOffsetCorrection',
                            tag_vr: [:SS], tag_vm: ["1"], tag_str: '(0052,0030)', tag_sym: :oct_z_offset_correction,
                            tag_ndm: '00520030', tag_ary: [0x0052,0x0030], tag_multiple: false,
                            tag_note: ''},
      [0x0040,0xE025] => { tag_ps: '(0040,E025)', tag_name: "WADO-RS Retrieval Sequence", tag_key: 'WADORSRetrievalSequence',
                            tag_vr: [:SQ], tag_vm: ["1"], tag_str: '(0040,E025)', tag_sym: :wado_rs_retrieval_sequence,
                            tag_ndm: '0040E025', tag_ary: [0x0040,0xE025], tag_multiple: false,
                            tag_note: ''},
      [0x0040,0x4072] => { tag_ps: '(0040,4072)', tag_name: "STOW-RS Storage Sequence", tag_key: 'STOWRSStorageSequence',
                            tag_vr: [:SQ], tag_vm: ["1"], tag_str: '(0040,4072)', tag_sym: :stow_rs_storage_sequence,
                            tag_ndm: '00404072', tag_ary: [0x0040,0x4072], tag_multiple: false,
                            tag_note: ''},
      [0x0028,0x7018] => { tag_ps: '(0028,7018)', tag_name: "CIExy White Point", tag_key: 'CIExyWhitePoint',
                            tag_vr: [:FL], tag_vm: ["2"], tag_str: '(0028,7018)', tag_sym: :ciexy_white_point,
                            tag_ndm: '00287018', tag_ary: [0x0028,0x7018], tag_multiple: false,
                            tag_note: ''},
      [0x0028,0x140F] => { tag_ps: '(0028,140F)', tag_name: "RGB LUT Transfer Function", tag_key: 'RGBLUTTransferFunction',
                            tag_vr: [:CS], tag_vm: ["1"], tag_str: '(0028,140F)', tag_sym: :rgb_lut_transfer_function,
                            tag_ndm: '0028140F', tag_ary: [0x0028,0x140F], tag_multiple: false,
                            tag_note: ''},
      [0x0018,0x9942] => { tag_ps: '(0018,9942)', tag_name: "CTDIvol Notification Trigger", tag_key: 'CTDIvolNotificationTrigger',
                            tag_vr: [:FD], tag_vm: ["1"], tag_str: '(0018,9942)', tag_sym: :ctdi_vol_notification_trigger,
                            tag_ndm: '00189942', tag_ary: [0x0018,0x9942], tag_multiple: false,
                            tag_note: ''},
      [0x0018,0x9412] => { tag_ps: '(0018,9412)', tag_name: "XA/XRF Frame Characteristics Sequence", tag_key: 'XAXRFFrameCharacteristicsSequence',
                            tag_vr: [:SQ], tag_vm: ["1"], tag_str: '(0018,9412)', tag_sym: :xa_xrf_frame_characteristics_sequence,
                            tag_ndm: '00189412', tag_ary: [0x0018,0x9412], tag_multiple: false,
                            tag_note: ''},
      [0x0018,0x8151] => { tag_ps: '(0018,8151)', tag_name: "X-Ray Tube Current in µA", tag_key: 'XRayTubeCurrentInuA',
                            tag_vr: [:DS], tag_vm: ["1"], tag_str: '(0018,8151)', tag_sym: :x_ray_tube_current_in_ua,
                            tag_ndm: '00188151', tag_ary: [0x0018,0x8151], tag_multiple: false,
                            tag_note: ''},
      [0x0018,0x8150] => { tag_ps: '(0018,8150)', tag_name: "Exposure Time in µS", tag_key: 'ExposureTimeInuS',
                            tag_vr: [:DS], tag_vm: ["1"], tag_str: '(0018,8150)', tag_sym: :exposure_time_in_us,
                            tag_ndm: '00188150', tag_ary: [0x0018,0x8150], tag_multiple: false,
                            tag_note: ''},
      [0x0018,0x1153] => { tag_ps: '(0018,1153)', tag_name: "Exposure in µAs", tag_key: 'ExposureInuAs',
                            tag_vr: [:IS], tag_vm: ["1"], tag_str: '(0018,1153)', tag_sym: :exposure_in_uas,
                            tag_ndm: '00181153', tag_ary: [0x0018,0x1153], tag_multiple: false,
                            tag_note: ''},
      [0x0018,0x1318] => { tag_ps: '(0018,1318)', tag_name: "dB/dt", tag_key: 'dBdt',
                            tag_vr: [:DS], tag_vm: ["1"], tag_str: '(0018,1318)', tag_sym: :db_dt,
                            tag_ndm: '00181318', tag_ary: [0x0018,0x1318], tag_multiple: false,
                            tag_note: ''}
    }
  end

  def self.unknown_group_length_sample
    {
      [16,0] => {tag_ps: '(0010,0000)', tag_str: '(0010,0000)', tag_ary: [0x0010,0x0000],
                 tag_sym: :group_length, tag_ndm: '00100000', tag_name: 'Group Length',
                 tag_key: 'GroupLength', tag_vr: [:UL], tag_vm: ['1'], tag_note: 'Dummy Record',
                 tag_multiple: false},
      [17,0] => {tag_ps: '(0011,0000)', tag_str: '(0011,0000)', tag_ary: [0x0011,0x0000],
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
      [0x1010,0xa1b2] => { tag_ps: '(1010,XXXX)', tag_name: "Zonal Map", tag_key: 'ZonalMap', tag_vr: [:US], tag_vm: ["1-n"], tag_str: '(1010,A1B2)', tag_sym: :zonal_map, tag_ndm: '1010A1B2', tag_ary: [0x1010, 0xa1b2], tag_multiple: true, tag_note: 'RET (2007)'},
      '(1010,A1B2)' => { tag_ps: '(1010,XXXX)', tag_name: "Zonal Map", tag_key: 'ZonalMap', tag_vr: [:US], tag_vm: ["1-n"], tag_str: '(1010,A1B2)', tag_sym: :zonal_map, tag_ndm: '1010A1B2', tag_ary: [0x1010, 0xa1b2], tag_multiple: true, tag_note: 'RET (2007)'},
      '1010A1B2' => { tag_ps: '(1010,XXXX)', tag_name: "Zonal Map", tag_key: 'ZonalMap', tag_vr: [:US], tag_vm: ["1-n"], tag_str: '(1010,A1B2)', tag_sym: :zonal_map, tag_ndm: '1010A1B2', tag_ary: [0x1010, 0xa1b2], tag_multiple: true, tag_note: 'RET (2007)'},
      '10100000' => { tag_ps: '(1010,0000)', tag_name: 'Group Length', tag_key: 'GroupLength', tag_vr: [:UL], tag_vm: ["1"], tag_str: '(1010,0000)', tag_sym: :group_length, tag_ndm: '10100000', tag_ary: [0x1010, 0x0000], tag_multiple: false, tag_note: 'Dummy Record'},
    }
  end

end
