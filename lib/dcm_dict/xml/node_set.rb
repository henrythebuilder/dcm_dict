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
require 'nokogiri'

module DcmDict
  module XML
    using DcmDict::StringRefine
    NODE_SET_IDX = { tag_ps: 0,
                     tag_name: 1,
                     tag_key: 2,
                     tag_vr: 3,
                     tag_vm: 4,
                     tag_note: 5 }

    def self.extract_node_set_data(node_set)
      data = {
        :tag_ps =>  extract_tag_ps_from_node_set(node_set),
        :tag_name =>  extract_tag_name_from_node_set(node_set),
        :tag_key =>  extract_tag_key_from_node_set(node_set),
        :tag_vr =>  extract_tag_vr_from_node_set(node_set),
        :tag_vm =>  extract_tag_vm_from_node_set(node_set),
        :tag_note => extract_tag_note_from_node_set(node_set)
      }
      extend_data_element_data(data)
    end

    private
    def self.extract_tag_ps_from_node_set(node_set)
      extract_content_data_from_node_set(node_set, NODE_SET_IDX[:tag_ps])
    end

    def self.extract_tag_name_from_node_set(node_set)
      extract_content_data_from_node_set(node_set, NODE_SET_IDX[:tag_name])
    end

    def self.extract_tag_key_from_node_set(node_set)
      extract_content_data_from_node_set(node_set, NODE_SET_IDX[:tag_key])
    end

    def self.extract_tag_vr_from_node_set(node_set)
      extract_multiple_data_from_node_set(node_set, NODE_SET_IDX[:tag_vr]).map(&:to_sym)
    end

    def self.extract_tag_vm_from_node_set(node_set)
      extract_multiple_data_from_node_set(node_set, NODE_SET_IDX[:tag_vm])
    end

    def self.extract_tag_note_from_node_set(node_set)
      extract_content_data_from_node_set(node_set, NODE_SET_IDX[:tag_note])
    end

    def self.extend_data_element_data(data)
      data[:tag_str] = extract_tag_str_from_data(data)
      data[:tag_sym] = extract_tag_sym_from_data(data)
      data[:tag_num] = extract_tag_num_from_data(data)
      data[:tag_ary] = extract_tag_ary_from_data(data)
      data[:tag_multiple] = data_with_multiple_tag?(data)
      data
    end

    def self.extract_tag_str_from_data(data)
      data[:tag_ps].gsub(/[xX|]/,'2')
    end

    def self.data_with_multiple_tag?(data)
      data[:tag_ps].index(/[xX|]/) ? true : false
    end

    def self.extract_tag_ary_from_data(data)
      data[:tag_str].tag_str_to_ary
    end

    def self.extract_tag_num_from_data(data)
      data[:tag_str].tag_str_to_digit_str
    end

    def self.extract_tag_sym_from_data(data)
      data[:tag_key].tag_key_to_sym
    end

    def self.extract_multiple_data_from_node_set(node_set, idx)
      extract_content_data_from_node_set(node_set, idx).split(' or ')
    end

    def self.extract_content_data_from_node_set(node_set, idx)
      return '' unless node_set[idx]
      node_set[idx].content.dcm_unspace
    end

  end
end
