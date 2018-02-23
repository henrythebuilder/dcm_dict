#!/usr/bin/env ruby
# -*- ruby -*-
#
#  Copyright (C) 2014-2018  Enrico Rivarola
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
require 'open-uri'
require 'tempfile'
require 'dcm_dict'
require 'dcm_dict/xml/xml_tool'

LICENSE_TEXT=<<END_LICENSE
  Copyright (C) 2014-2018  Enrico Rivarola

  This file is part of DcmDict gem (dcm_dict).

  DcmDict is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  DcmDict is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with DcmDict.  If not, see <http://www.gnu.org/licenses/>.

  This software has neither been tested nor approved for clinical use
  or for incorporation in a medical device.
  It is the redistributor's or user's responsibility to comply with any
  applicable local, state, national or international regulations

END_LICENSE

class DcmDictConverter
  Part6XmlUrl="ftp://medical.nema.org/medical/dicom/current/source/docbook/part06/part06.xml"
  Part7XmlUrl="ftp://medical.nema.org/medical/dicom/current/source/docbook/part07/part07.xml"
  DataElementSource={
    Part7XmlUrl => ["table_E.1-1", "table_E.2-1"],
    Part6XmlUrl => ["table_7-1", "table_8-1", "table_6-1"]
  }

  UidSource={
    Part6XmlUrl => ["table_A-1"]
  }

  DataElementFix = {
    "table_E.2-1" => {:tag_note => 'RET'}
  }

  def initialize

  end

  def print_out_tag
    trace("Print out data to stdout\n")
    print_out_data_elements()
    trace("Print out done.\n")
  end

  def print_out_uid
    trace("Print out data to stdout\n")
    print_out_uid_data()
    trace("Print out done.\n")
  end

  private
  def pull_standard_draft(url, output)
    buffer_size = 256 * 1_024
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

  def extract_node_set(xml_file, table_to_map)
    xml_doc = DcmDict::XML::XmlTool.create_xml_doc(File.read(xml_file))
    table_to_map.each do |table|
      trace("Extracting data from '#{table}':")
      xpath="//xmlns:table[@xml:id=\"#{table}\"]//xmlns:tbody/xmlns:tr"
      DcmDict::XML::XmlTool.each_tr_set(xml_doc, xpath) do |tdset|
        yield(table, tdset)
      end
      trace("Done.\n")
    end
  end

  def extract_data_element(xml_file, table_to_map)
    extract_node_set(xml_file, table_to_map) do |table, td|
      data = DcmDict::XML::XmlTool.extract_data_element_field_from_tr_set(td)
      check_data_element_data(data, table)
      yield(data) if block_given?
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
      Tempfile.create('dcmps') do |xml_file|
        pull_standard_draft(url, xml_file)
        extract_data_element(xml_file, table_to_map) do |data|
          print_out(DcmDict::Encoder::DataToCode.data_element_data_to_code(data, 6))
          print_out("\r\n")
          trace('.')
        end
      end
    end
    print_out(DcmDict::Encoder::DataToCode.data_element_footer)
  end

  def extract_uid(xml_file, table_to_map)
    extract_node_set(xml_file, table_to_map) do |table, td|
      data = DcmDict::XML::XmlTool.extract_uid_field_from_tr_set(td)
      yield(data) if block_given?
    end
  end

  def print_out_uid_data()
    print_out(DcmDict::Encoder::DataToCode.uid_header)
    UidSource.each do |url, table_to_map|
      Tempfile.create('dcmps') do |xml_file|
        pull_standard_draft(url, xml_file)
        extract_uid(xml_file, table_to_map) do |data|
          print_out(DcmDict::Encoder::DataToCode.uid_data_to_code(data, 6))
          print_out("\r\n")
          trace('.')
        end
      end
    end
    print_out(DcmDict::Encoder::DataToCode.uid_footer)
  end

  def print_out(string)
    $stdout.print(string)
  end

  def trace(msg)
    $stderr.print(msg)
  end

end

STDERR << LICENSE_TEXT
STDERR << "\nAny key to continue or Ctrl-C to break.\n"
STDIN.getc

if (DcmDict::XML.nokogiri_enable?)
  STDERR << "Parsing XML data with Nokogiri.\n\n"
else
  STDERR << "Parsing XML data with REXML.\n\n"
end

case ARGV[0]
when "tag"
  DcmDictConverter.new.print_out_tag
when "uid"
  DcmDictConverter.new.print_out_uid
else
  STDERR << "\nwrong option: use 'tag' or 'uid' (ie dcm_dict_converter.rb tag > uid_values.rb)\n"
end
