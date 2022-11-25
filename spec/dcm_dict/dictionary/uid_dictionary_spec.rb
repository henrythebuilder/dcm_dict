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

describe DcmDict::Dictionary::UidDictionary do

  include_examples "Map all source data",
                   [:uid_value, :uid_name, :uid_key, :uid_sym],
                   DcmDict::SourceData::UidValuesData,
                   DcmDict::Dictionary::TheUidDictionary,
                   DcmDict::Dictionary::UidRecord,
                   [:uid_value, :uid_name, :uid_key, :uid_sym, :uid_type]

  {
    '1.2.3.4.5.6'                   => { :uid_value => '1.2.3.4.5.6',
                                         :uid_name  => '1.2.3.4.5.6 (Unknown UID)',
                                         :uid_type  => :unknown,
                                         :uid_key   => 'UID_1_2_3_4_5_6',
                                         :uid_sym   => :uid_1_2_3_4_5_6,
                                       },
    '1.2.840.10008.5.1.4.1.1.12.77' => { :uid_value => '1.2.840.10008.5.1.4.1.1.12.77',
                                         :uid_name  => '1.2.840.10008.5.1.4.1.1.12.77 (Retired)',
                                         :uid_key   => 'UID_1_2_840_10008_5_1_4_1_1_12_77',
                                         :uid_sym   => :uid_1_2_840_10008_5_1_4_1_1_12_77,
                                         :uid_type  => :sop_class
                                       },
    '1.2.840.10008.5.1.4.1.1.12.77 (Retired)' => { :uid_value => '1.2.840.10008.5.1.4.1.1.12.77',
                                         :uid_name  => '1.2.840.10008.5.1.4.1.1.12.77 (Retired)',
                                         :uid_key   => 'UID_1_2_840_10008_5_1_4_1_1_12_77',
                                         :uid_sym   => :uid_1_2_840_10008_5_1_4_1_1_12_77,
                                         :uid_type  => :sop_class
                                       },
    'UID_1_2_840_10008_5_1_4_1_1_12_77' => { :uid_value => '1.2.840.10008.5.1.4.1.1.12.77',
                                         :uid_name  => '1.2.840.10008.5.1.4.1.1.12.77 (Retired)',
                                         :uid_key   => 'UID_1_2_840_10008_5_1_4_1_1_12_77',
                                         :uid_sym   => :uid_1_2_840_10008_5_1_4_1_1_12_77,
                                         :uid_type  => :sop_class
                                       },
    :uid_1_2_840_10008_5_1_4_1_1_12_77 => { :uid_value => '1.2.840.10008.5.1.4.1.1.12.77',
                                         :uid_name  => '1.2.840.10008.5.1.4.1.1.12.77 (Retired)',
                                         :uid_key   => 'UID_1_2_840_10008_5_1_4_1_1_12_77',
                                         :uid_sym   => :uid_1_2_840_10008_5_1_4_1_1_12_77,
                                         :uid_type  => :sop_class
                                       },
    '1.2.840.10008.5.1.4.1.1.40'    => { :uid_value => '1.2.840.10008.5.1.4.1.1.40',
                                         :uid_name  => '1.2.840.10008.5.1.4.1.1.40 (Retired)',
                                         :uid_key   => 'UID_1_2_840_10008_5_1_4_1_1_40',
                                         :uid_sym   => :uid_1_2_840_10008_5_1_4_1_1_40,
                                         :uid_type  => :sop_class
                                       },
    '1.2.840.10008.5.1.4.39.3'      => { :uid_value => '1.2.840.10008.5.1.4.39.3',
                                         :uid_name  => 'Color Palette Query/Retrieve Information Model - MOVE',
                                         :uid_key   => 'ColorPaletteQueryRetrieveInformationModelMove',
                                         :uid_sym   => :color_palette_query_retrieve_information_model_move,
                                         :uid_type  => :sop_class
                                       },
    'Color Palette Query/Retrieve Information Model - MOVE' => { :uid_value => '1.2.840.10008.5.1.4.39.3',
                                         :uid_name  => 'Color Palette Query/Retrieve Information Model - MOVE',
                                         :uid_key   => 'ColorPaletteQueryRetrieveInformationModelMove',
                                         :uid_sym   => :color_palette_query_retrieve_information_model_move,
                                         :uid_type  => :sop_class
                                       },
    'ColorPaletteQueryRetrieveInformationModelMove'         => { :uid_value => '1.2.840.10008.5.1.4.39.3',
                                         :uid_name  => 'Color Palette Query/Retrieve Information Model - MOVE',
                                         :uid_key   => 'ColorPaletteQueryRetrieveInformationModelMove',
                                         :uid_sym   => :color_palette_query_retrieve_information_model_move,
                                         :uid_type  => :sop_class
                                       },
    :color_palette_query_retrieve_information_model_move    => { :uid_value => '1.2.840.10008.5.1.4.39.3',
                                         :uid_name  => 'Color Palette Query/Retrieve Information Model - MOVE',
                                         :uid_key   => 'ColorPaletteQueryRetrieveInformationModelMove',
                                         :uid_sym   => :color_palette_query_retrieve_information_model_move,
                                         :uid_type  => :sop_class
                                       },
    '1.2.840.10008.1.4.1.6'             => { :uid_value => '1.2.840.10008.1.4.1.6',
                                            :uid_name  => 'SPM2 FIL T1 Frame of Reference',
                                            :uid_key   => 'SPM2FILT1',
                                            :uid_sym   => :spm2filt1,
                                            :uid_type  => :well_known_frame_of_reference
                                     },
    'SPM2 FIL T1 Frame of Reference'    => { :uid_value => '1.2.840.10008.1.4.1.6',
                                            :uid_name  => 'SPM2 FIL T1 Frame of Reference',
                                            :uid_key   => 'SPM2FILT1',
                                            :uid_sym   => :spm2filt1,
                                            :uid_type  => :well_known_frame_of_reference
                                      },
    'SPM2FILT1'                         => { :uid_value => '1.2.840.10008.1.4.1.6',
                                             :uid_name  => 'SPM2 FIL T1 Frame of Reference',
                                             :uid_key   => 'SPM2FILT1',
                                             :uid_sym   => :spm2filt1,
                                             :uid_type  => :well_known_frame_of_reference
                                       },
    :spm2filt1                          => { :uid_value => '1.2.840.10008.1.4.1.6',
                                             :uid_name  => 'SPM2 FIL T1 Frame of Reference',
                                             :uid_key   => 'SPM2FILT1',
                                             :uid_sym   => :spm2filt1,
                                             :uid_type  => :well_known_frame_of_reference
                                        },
    '1.2.840.10008.1.4.3.2'             => { :uid_value => '1.2.840.10008.1.4.3.2',
                                             :uid_name  => 'Standard Robotic-Arm Coordinate System Frame of Reference',
                                             :uid_key   => 'StandardRoboticArmCoordinateSystem',
                                             :uid_sym   => :standard_robotic_arm_coordinate_system,
                                             :uid_type  => :well_known_frame_of_reference
                                        },
    '1.2.840.10008.5.1.1.25'            => { :uid_value => '1.2.840.10008.5.1.1.25',
                                             :uid_name  => 'Print Queue SOP Instance (Retired)',
                                             :uid_key   => 'PrintQueueInstance',
                                             :uid_sym   => :print_queue_instance,
                                             :uid_type  => :well_known_sop_instance
                                        },
  }.each do |uid, data|
    include_examples "Handle specific record", data[:uid_name],
                     uid, data, DcmDict::Dictionary::TheUidDictionary
  end

  [
    '1.2.abc.3.4', 'this string is not a valid uid', '1.2.3.04.5'
  ].each do |uid|
    include_examples "Dictionary with wrong key",
                     uid, [:uid_value, :uid_name, :uid_type, :uid_key, :uid_sym],
                     DcmDict::Dictionary::TheUidDictionary
  end

  include_examples "Dictionary Data not modifiable",
                   '1.2.840.10008.1.2', :uid_value, DcmDict::Dictionary::TheUidDictionary


  include_examples "Concurrency support",
                   '1.2.840.10008.1.2',
                   DcmDict::Dictionary::TheUidDictionary,
                   {uid_value: '1.2.840.10008.1.2',
                    uid_name: "Implicit VR Little Endian: Default Transfer Syntax for DICOM",
                    uid_type: :transfer_syntax}

end
