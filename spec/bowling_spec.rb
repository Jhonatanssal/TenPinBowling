# frozen_string_literal: true

# spec/bowling_spec.rb

require 'spec_helper'
require_relative '../lib/bowling'
require_relative '../lib/player'

describe Bowling do
  before do
    @file = ''
    @bowling = Bowling.new
    @player = Player.new('jeff')
  end

  describe '#get_file_info' do
    it 'returns an array' do
      expect(@bowling.get_file_info('test.txt')).to be_an_instance_of(Array)
    end

    it 'returns an array of length 2' do
      expect(@bowling.get_file_info('test.txt').length).to be(2)
    end

    it "contains 'Jeff' and 'John'" do
      expect(@bowling.get_file_info('test.txt')[1]).to eq(%w[jeff john])
    end
  end

  describe '#create_players' do
    before do
      @names_arr = %w[Jeff John]
    end

    it 'creates instances of Player class' do
      expect(@bowling.create_players(@names_arr)[0]).to be_an_instance_of Player
    end
  end
end
