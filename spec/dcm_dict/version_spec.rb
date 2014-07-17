require 'spec_helper'

module DcmDict
  describe "DcmDict version" do
    it "may be defined" do
      expect(DcmDict::VERSION).not_to be_nil
    end
  end
end
