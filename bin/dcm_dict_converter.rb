#!/usr/bin/env ruby
# -*- ruby -*-
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
require 'open-uri'
require 'tempfile'
require 'nokogiri'
require 'dcm_dict'
require 'dcm_dict/xml/nokogiri_tool'

class DcmDictConverter
  Part6XmlUrl="http://dicom.nema.org/medical/dicom/2014a/source/docbook/part06/part06.xml"
  Part7XmlUrl="http://dicom.nema.org/medical/dicom/2014a/source/docbook/part07/part07.xml"
  DataElementSource={
    Part7XmlUrl => ["table_E.1-1", "table_E.2-1"],
    Part6XmlUrl => ["table_7-1", "table_8-1", "table_6-1"]
  }

  DataElementFix = {
    "table_E.2-1" => {:tag_note => 'RET'}
  }

  def initialize

  end

  def print_out_data
    trace("Print out data to stdout\n")
    print_out_data_elements()
    trace("Print out done.\n")
  end

  private
  def pull_standard_draft(url, output)
    buffer_size = 512 * 1_024
    trace("Downloading #{url}\n")
    open(url, "r",
         :content_length_proc => lambda {|content_length| trace("Content Length: #{content_length} bytes\n.") },
         :progress_proc => lambda { |size| trace(".") }) do |src|
      while (buffer = src.read(buffer_size))
        output.write(buffer)
      end
    end
    trace("Done.\n")
    output.flush
    output.rewind
  end

  def extract_data_element(xml_file, table_to_map)
    noko_doc = Nokogiri::XML(xml_file)
    table_to_map.each do |table|
      trace("Extracting data elements data from '#{table}':")
      xpath="//xmlns:table[@xml:id=\"#{table}\"]//xmlns:tbody/xmlns:tr"
      trs = noko_doc.xpath(xpath)
      trs.each do |tr|
        td = tr.xpath('xmlns:td')
        noko_proc = DcmDict::Xml::NokogiriTool.tag_field_extract_proc(td)
        data =  DcmDict::XML::NodeSetData.new(noko_proc).data_element_data
        check_data_element_data(data, table)
        yield(data) if block_given?
      end
      trace("Done.\n")
    end
  end

  def check_data_element_data(data, table)
    if (DataElementFix.has_key?(table))
      DataElementFix[table].each{|key, val| data[key]=val if data[key].empty?}
    end
  end

  def print_out_data_elements()
    print_out(DcmDict::Encoder::DataToCode.data_element_header)
    DataElementSource.each do |url, table_to_map|
      Tempfile.create('dcm') do |xml_file|
        pull_standard_draft(url, xml_file)
        extract_data_element(xml_file, table_to_map) do |data|
          print_out(DcmDict::Encoder::DataToCode.data_element_data_to_code(data, indent: 6))
          print_out("\r\n")
          trace('.')
        end
      end
    end
    print_out(DcmDict::Encoder::DataToCode.data_element_footer)
  end

  def print_out(string)
    $stdout.print(string)
  end

  def trace(msg)
    $stderr.print(msg)
  end

end

DcmDictConverter.new.print_out_data
