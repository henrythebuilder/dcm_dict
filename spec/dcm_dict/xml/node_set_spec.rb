# coding: utf-8

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
require 'spec_helper'
require 'xml_sample_spec_helper'

module DcmDict
  describe "XML management" do

    XmlSampleSpecHelper.xml_single_set.each do |xml_string, data|
      it "should extract data from single node set for '#{data[:tag_name]}'" do
        xml_doc  = Nokogiri::XML(xml_string)
        tr = xml_doc.xpath('//tr')
        td = tr[0].xpath('td')
        xml_data = DcmDict::XML.extract_node_set_data(td)
        data.each do |key, value|
          expect(xml_data[key]).to eq(value)
        end
      end
    end
  end
end
