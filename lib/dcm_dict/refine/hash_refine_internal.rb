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
module DcmDict
  module Refine
    module HashRefineInternal

      refine Hash do
        def check_placeholder_data!
          # PS3.5:
          # For some Data Elements, no Name or Keyword or VR or VM is specified;
          # these are "placeholders" that are not assigned but will not be reused.
          tag_ps = self[:tag_ps]
          raise "Missing tag_ps field" if tag_ps.nil? || tag_ps.empty?
          if self[:tag_name].nil? || self[:tag_name].empty?
            self[:tag_name] = "Placeholder #{tag_ps}"
          end
          if self[:tag_key].nil? || self[:tag_key].empty?
            new_key = tag_ps.gsub(',','_').gsub(/[\(\)]/,'')
            self[:tag_key] = "Placeholder_#{new_key}"
          end
          if self[:tag_vr].nil? || self[:tag_vr].empty?
            self[:tag_vr] = [:UN]
          end
          if self[:tag_vm].nil? || self[:tag_vm].empty?
            self[:tag_vm] = ['1']
          end
        end
      end
    end
  end
end
