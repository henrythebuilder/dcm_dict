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

module DcmDict
  module XML

    begin
      require 'nokogiri'
      #  raise LoadError.new "boom"
      NOKOGIRI_ENABLE = true
    rescue LoadError
      NOKOGIRI_ENABLE = false
    end

    if NOKOGIRI_ENABLE

      module NokogiriTool
        def self.extract_data_element_field_from_xml_tr(xml_tr_string)
          nodeset = extract_nokogiri_nodeset(xml_tr_string)
          proc = tag_field_extract_proc(nodeset)
          TagFieldData.new(proc).data_element_data
        end

        def self.extract_uid_field_from_xml_tr(xml_tr_string)
          nodeset = extract_nokogiri_nodeset(xml_tr_string)
          proc = uid_field_extract_proc(nodeset)
          UidFieldData.new(proc).uid_data
        end

        private
        def self.tag_field_extract_proc(node_set)
          make_nokogiri_proc(node_set, DataElementNodeSetIdx)
        end

        def self.uid_field_extract_proc(node_set)
          make_nokogiri_proc(node_set, UidNodeSetIdx)
        end

        def self.make_nokogiri_proc(node_set, node_set_idx)
          Proc.new do |key|
            idx = node_set_idx[key]
            node_set[idx] ? node_set[idx].content.gsub(/ {2,}/, '') : ''
          end
        end

        def self.extract_nokogiri_nodeset(xml_tr_string)
          xml_doc  = Nokogiri::XML(xml_tr_string)
          tr = xml_doc.xpath('//tr')
          tr[0].xpath('td')
        end
      end

    end
  end
end
