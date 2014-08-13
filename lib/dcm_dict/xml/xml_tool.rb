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
require_relative 'constant'
require_relative 'rexml_tool'
require_relative 'nokogiri_tool'

module DcmDict
  module XML

    # Main tool to handle xml data for uid and data element
    module XmlTool
      @@xml_tool = XML.nokogiri_enable? ? NokogiriTool : RexmlTool

      def self.extract_data_element_field_from_xml_tr(xml_tr_string)
        @@xml_tool.extract_data_element_field_from_xml_tr(xml_tr_string)
      end

      def self.extract_data_element_field_from_tr_set(trset)
        @@xml_tool.extract_data_element_field_from_tr_set(trset)
      end

      def self.extract_uid_field_from_xml_tr(xml_tr_string)
        @@xml_tool.extract_uid_field_from_xml_tr(xml_tr_string)
      end

      def self.extract_uid_field_from_tr_set(trset)
        @@xml_tool.extract_uid_field_from_tr_set(trset)
      end

      def self.create_xml_doc(xml_string)
        @@xml_tool.create_xml_doc(xml_string)
      end

      def self.each_tr_set(doc, xpath, &block)
        @@xml_tool.each_tr_set(doc, xpath, &block)
      end
    end
  end
end
