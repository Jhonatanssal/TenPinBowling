# frozen_string_literal: true

# spec/bowling_spec.rb

require 'spec_helper'
require_relative '../lib/bowling'
require_relative '../lib/player'

describe Bowling do

  describe '#create_players' do
    before do
      @names_arr = %w[Jeff]
      @file_name = 'test.txt'
      @bowling = Bowling.new(@file_name)
    end

    it 'creates instance of Player class' do
      expect(@bowling.create_players(@names_arr)[0]).to be_an_instance_of Player
    end
  end
end
