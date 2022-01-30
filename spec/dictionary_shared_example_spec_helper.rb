#
#  Copyright (C) 2014-2022  Enrico Rivarola
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

FrozenStringExMessage = (RUBY_ENGINE == 'rbx') ? "can't modify frozen instance of String" : "can't modify frozen String"

RSpec.shared_examples "Record handle methods correctly" do |obj, data|
  it "Handle methods correctly" do
    data.each do |key, expected_val|
      expect(obj.respond_to?(key.to_sym)).to be true
      expect(obj.respond_to?(key.to_s)).to be true
    end

    expect(obj.respond_to?(:undefined_method_for_record)).to be false
    expect(obj.respond_to?(:undefined_method_for_record.to_s)).to be false
    expect{ obj.undefined_method_for_record }.to raise_error(NoMethodError)
    expect{ obj.send("undefined_method_for_record") }.to raise_error(NoMethodError)
  end
end

RSpec.shared_examples "Concurrency support" do |key, dictionary, expected_values|
  it "should support concurrency" do
    #start = Time.now
    max_threads = 128
    times_for_threads = 1_024
    idx = Random.rand(0...expected_values.size)
    rnd_key = expected_values.keys[idx]
    rnd_val = expected_values[rnd_key]
    Thread.abort_on_exception = true
    th = (1..max_threads).map do |n|
      Thread.new do
        Thread.stop
        times_for_threads.times do |t|
          Thread.current[:obj] = dictionary.record_at(key)
          expect( Thread.current[:obj].send(rnd_key) ).to eq(rnd_val)
          expect( dictionary.feature_at(key, rnd_key) ).to eq(rnd_val)
          Thread.pass
        end
      end
    end
    sleep 0.01 while th[max_threads-1].status!='sleep'
    th.map(&:run).map(&:join)
    #warn "Example 'should support concurrency' finish in #{Time.now-start}"
  end
end

RSpec.shared_examples "Map all source data" do |index_keys, record_data, dictionary, record_type, field_list|
  it "should map all source data" do
    record_data.each do |record|
      index_keys.each do |key|
        obj = dictionary.record_at(record[key])
        expect(obj).not_to be_nil, "#{key.inspect} > #{record[key].inspect}"
        expect(obj).to be_a(record_type)
        expect(obj).to be_frozen
        field_list.each do |field|
          feature = dictionary.feature_at(record[key], field)
          expect(feature).to eq(record[field])
        end
      end
    end
  end
end

RSpec.shared_examples "Handle specific record" do |note, record_key, record_data, dictionary|
  it "should handle specific record as #{record_key.inspect} (#{note})" do
      obj = dictionary.record_at(record_key)
      expect(obj).not_to be_nil, "#{record_key.inspect} not found into dictionary #{dictionary.class}"
      record_data.each do |key, value|
        field = obj.send(key)
        expect(field).to eq(value)
        feature = dictionary.feature_at(record_key, key)
        expect(feature).to eq(value)
      end
    end
end

RSpec.shared_examples "Dictionary Data not modifiable" do |record_key, key, dictionary|
  it "data should be not modifiable" do
    expect(dictionary).to be_frozen
    obj = dictionary.record_at(record_key)
    expect(obj).to be_frozen
    expect{ eval("obj.#{key} << 'aaa'") }.
      to raise_error(FrozenError)
    expect{ eval("dictionary.feature_at('#{record_key}', #{key.inspect}) << 'aaa'") }.
      to raise_error(FrozenError)
  end
end

RSpec.shared_examples "Dictionary with wrong key" do |record_key, field_list, dictionary|
  it "should raise exception for wrong value as #{record_key.inspect}" do
    expect{dictionary.record_at(record_key)}.
      to raise_error(DcmDict::DictionaryError)
    field_list.each do |field|
      expect { dictionary.feature_at(record_key, field) }.
        to raise_error(DcmDict::DictionaryError)
    end
  end
end
