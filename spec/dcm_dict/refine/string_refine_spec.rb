# coding: utf-8
require 'spec_helper'

module DcmDict
  describe "String refinement" do
    using DcmDict::StringRefine
    [
      ["FileSetDescriptorFileID ", "trailing spaces"],
      ["  FileSetDescriptorFileID", "leading spaces"],
      ["  FileSetDescriptorFileID  ", "leading and trailing spaces"],
      ["File​Set​Descriptor​FileID", "zero width spaces"],
      ["  File​Set​Descriptor​FileID  ", "leading, trailing and zero width spaces"]
    ].each do |wrong_string, comment|
      it "may remove unwanted space such as '#{comment}'" do
        expect(wrong_string.dcm_unspace).to eq('FileSetDescriptorFileID')
      end
    end
  end
end
