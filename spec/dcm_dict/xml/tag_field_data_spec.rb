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
require 'xml_sample_spec_helper'



describe "XML management for Data Element" do

  RSpec.shared_examples "XML management for Data Element" do |xml_mod, desc|
    describe "should extract data from single node set data (#{desc})" do
      XmlSampleSpecHelper.xml_tag_single_set.each do |xml_string, expected_data|
        xml_data = xml_mod.extract_data_element_field_from_xml_tr(xml_string)
        describe "for '#{expected_data[:tag_name]}'" do
          expected_data.each do |key, expected_value|
            it "with key #{key.inspect}" do
              expect(xml_data[key]).to eq(expected_value)
            end
          end
          it "from XML doc" do
            doc = xml_mod.create_xml_doc(xml_string)
            data = {}
            xml_mod.each_tr_set(doc, '//xmlns:tr') do |trset|
              data = xml_mod.extract_data_element_field_from_tr_set(trset)
            end
            expect(data).to eq(expected_data)
          end
        end
      end
    end
  end

  if DcmDict::XML.nokogiri_enable?
    include_examples "XML management for Data Element", DcmDict::XML::NokogiriTool, "with Nokogiri"
  end

  include_examples "XML management for Data Element", DcmDict::XML::RexmlTool, "with REXML"

  include_examples "XML management for Data Element", DcmDict::XML::XmlTool, "with general XML module"

end
