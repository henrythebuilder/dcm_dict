module DcmDict
  module StringRefine
    refine String do
      def dcm_unspace
        zero_width_space = "\u200B"
        self.gsub(zero_width_space, '').strip
      end
    end
  end
end
