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
require "dcm_dict/version"
require "dcm_dict/error/dictionary_error"
require "dcm_dict/ext/object_extension"
require "dcm_dict/refine/internal/string_refine_internal"
require "dcm_dict/refine/internal/array_refine_internal"
require "dcm_dict/refine/internal/hash_refine_internal"
require "dcm_dict/xml/constant"
require "dcm_dict/xml/field_data"
require "dcm_dict/xml/tag_field_data"
require "dcm_dict/xml/uid_field_data"
require "dcm_dict/encoder/data_to_code"
require "dcm_dict/source_data/data_elements_data"
require "dcm_dict/source_data/uid_values_data"
require "dcm_dict/source_data/detached_data"
require "dcm_dict/dictionary/data_element_record"
require "dcm_dict/dictionary/data_element_dictionary"
require "dcm_dict/dictionary/uid_record"
require "dcm_dict/dictionary/uid_dictionary"
require "dcm_dict/refine/data_element_refine"
require "dcm_dict/refine/uid_refine"
require "dcm_dict/refine/string_refine"
require "dcm_dict/refine/array_refine"
require "dcm_dict/refine/symbol_refine"
