#
#  Copyright (C) 2014-2017  Enrico Rivarola
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
    @@nokogiri_enable = false

    begin
      #raise LoadError.new "Simulate LoadError to disable Nokogiri"
      require 'nokogiri'
      @@nokogiri_enable = true
    rescue LoadError
    end

    # Check for Nokogiri gem
    def self.nokogiri_enable?
      @@nokogiri_enable
    end

    if @@nokogiri_enable
      module NokogiriTool

        # Extract data element data from a table row using +xml_tr_string+ as source string
        def self.extract_data_element_field_from_xml_tr(xml_tr_string)
          nodeset = extract_nokogiri_nodeset(xml_tr_string)
          extract_data_element_field_from_tr_set(nodeset)
        end

        # Extract data element data from xml table row using +trset+ (NodeSet) as source
        def self.extract_data_element_field_from_tr_set(trset)
          proc = tag_field_extract_proc(trset)
          TagFieldData.new(proc).data_element_data
        end

        # Extract uid data from a table row using +xml_tr_string+ as source string
        def self.extract_uid_field_from_xml_tr(xml_tr_string)
          nodeset = extract_nokogiri_nodeset(xml_tr_string)
          extract_uid_field_from_tr_set(nodeset)
        end

        # Extract uid data from a table row using +trset+ (NodeSet) as source
        def self.extract_uid_field_from_tr_set(trset)
          proc = uid_field_extract_proc(trset)
          UidFieldData.new(proc).uid_data
        end

        # Create XML root object from xml source string +xml_string+
        def self.create_xml_doc(xml_string)
          Nokogiri::XML(xml_string)
        end

        # Calls the given block from +doc+ once for each 'table row' identified by +xpath+
        def self.each_tr_set(doc, xpath)
          alltr = doc.xpath(xpath)
          alltr.each do |tr|
            trset = tr.xpath('xmlns:td')
            yield trset if block_given?
          end
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
          doc  = create_xml_doc(xml_tr_string)
          each_tr_set(doc, '//xmlns:tr') do |tdset|
            return tdset
          end
        end
      end
    end

  end
end
