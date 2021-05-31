# frozen_string_literal: true

# spec/bowling_spec.rb

require 'spec_helper'
require_relative '../lib/input'
require_relative '../lib/errors'

describe Input do

  before do
    @file = ''
    @input = Input.new
    @file_name = 'test.txt'
    file_info = @input.get_file_info(@file_name)
  end

  describe '#get_file_info' do
    it 'returns an array' do
      expect(@input.get_file_info(@file_name)).to be_an_instance_of(Array)
    end

    it 'returns an array of length 2' do
      expect(@input.get_file_info(@file_name)[1].length).to be(2)
    end

    it "contains 'Jeff' and 'John'" do
      expect(@input.get_file_info(@file_name)[1]).to eq(%w[jeff john])
    end
  end
end