#
#  Copyright (C) 2014-2020  Enrico Rivarola
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
  module Refine
    module Internal
      module HashRefineInternal

        refine Hash do
          # Check/update content for data tag field
          def check_base_data_tag_field!
            check_tag_ps!
            check_placeholder_data!
            self
          end

          # Check for mandatory :tag_ps key
          def check_tag_ps!
            tag_ps = self[:tag_ps]
            raise "Missing tag_ps field" if tag_ps.nil_or_empty?
            tag_ps.upcase!
          end

          # Check for place holder tag data
          def check_placeholder_data!
            # PS3.5:
            # For some Data Elements, no Name or Keyword or VR or VM is specified;
            # these are "placeholders" that are not assigned but will not be reused.
            tag_ps = self[:tag_ps]
            raise "Missing tag_ps field" if tag_ps.nil_or_empty?
            fill_nil_or_empty_value(:tag_name) { "Placeholder #{tag_ps}" }
            fill_nil_or_empty_value(:tag_key) do
              new_key = tag_ps.gsub(',','_').gsub(/[\(\)]/,'')
              "Placeholder_#{new_key}"
            end
            fill_nil_or_empty_value(:tag_vr) { [:UN] }
            fill_nil_or_empty_value(:tag_vm) { ['1'] }
          end

          private
          def fill_nil_or_empty_value(key)
            if self[key].nil_or_empty?
              self[key] = yield
            end
          end
        end

      end
    end
  end
end
