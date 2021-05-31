# frozen_string_literal: true

# spec/player_spec.rb

require 'spec_helper'
require_relative '../lib/player'
require_relative '../lib/bowling'

describe Player do
  describe 'average game' do
    before do
      file = 'test.txt'
      @bowling = Bowling.new
      @arr = @bowling.get_file_info(file)[0]
      @names_arr = @bowling.get_file_info(file)[1]

      @name = @names_arr.uniq.first
      @first_player = Player.new(@name)
      @number_of_players = @names_arr.uniq.size
    end

    describe 'player name' do
      it 'returns the name of the first player' do
        expect(@first_player.name).to eq(@name)
      end
    end

    describe 'set scores' do
      it 'checks that the array of scores is not null' do
        expect(@first_player.set_scores(@arr, @names_arr.uniq.size)).not_to be_empty || nill
      end

      it 'returns an array of scores per turn for each player' do
        scores_array = [['10'], %w[7 3], %w[9 0], ['10'], %w[0 8], %w[8 2], %w[F 6], ['10'], ['10'],
                        %w[10 8 1]]

        expect(@first_player.set_scores(@arr, @number_of_players)).to eq(scores_array)
      end
    end

    describe 'total scores' do
      it 'checks array returned by method is not nill' do
        scores_array = @first_player.set_scores(@arr, @number_of_players)
        expect(@first_player.total_scores(scores_array)).not_to be_empty || null
      end

      it 'checks array returned by method is not nill' do
        scores_array = @first_player.set_scores(@arr, @number_of_players)
        totals = [20, 39, 48, 66, 74, 84, 90, 120, 148, 167]
        expect(@first_player.total_scores(scores_array)).to eq(totals)
      end
    end
  end

  describe 'perfect and worst case game' do
    before do
      @bowling = Bowling.new
      file = 'test0.txt'
      @arr = @bowling.get_file_info(file)[0]
      @names_arr = @bowling.get_file_info(file)[1]

      @name1 = @names_arr.uniq.first
      @name2 = @names_arr.uniq[1]
      @first_player = Player.new(@name1)
      @second_player = Player.new(@name2)
      @number_of_players = @names_arr.uniq.size
    end

    describe 'player name' do
      it 'returns the name of the first player' do
        expect(@first_player.name).to eq(@name1)
      end
    end

    describe 'perfect game' do
      describe 'set scores perfect game' do
        it 'checks that the array of scores is not null' do
          expect(@first_player.set_scores(@arr, @names_arr.uniq.size)).not_to be_empty || nill
        end

        it 'returns an array of scores per turn for first player' do
          scores_array = [['10'], ['10'], ['10'], ['10'], ['10'], ['10'], ['10'], ['10'], ['10'], %w[10 10 10]]

          expect(@first_player.set_scores(@arr, @number_of_players)).to eq(scores_array)
        end
      end

      describe 'total scores perfect game' do
        it 'checks array returned by method is not nill' do
          scores_array = @first_player.set_scores(@arr, @number_of_players)

          expect(@first_player.total_scores(scores_array)).not_to be_empty || null
        end

        it 'checks array returned by method is not nill' do
          scores_array = @first_player.set_scores(@arr, @number_of_players)
          totals = [30, 60, 90, 120, 150, 180, 210, 240, 270, 300]

          expect(@first_player.total_scores(scores_array)).to eq(totals)
        end
      end
    end

    describe 'worst case game' do
      describe 'set scores perfect game' do
        it 'checks that the array of scores is not null' do
          expect(@second_player.set_scores(@arr, @names_arr.uniq.size)).not_to be_empty || nill
        end

        it 'returns an array of scores per turn for first player' do
          scores_array = [%w[0 0], %w[0 0], %w[0 0], %w[0 0], %w[0 0], %w[0 0], %w[0 0],
                          %w[0 0], %w[0 0], %w[0 0]]

          expect(@second_player.set_scores(@arr, @number_of_players)).to eq(scores_array)
        end
      end

      describe 'total scores perfect game' do
        it 'checks array returned by method is not nill' do
          scores_array = @second_player.set_scores(@arr, @number_of_players)

          expect(@second_player.total_scores(scores_array)).not_to be_empty || null
        end

        it 'checks array returned by method is not nill' do
          scores_array = @second_player.set_scores(@arr, @number_of_players)
          totals = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]

          expect(@first_player.total_scores(scores_array)).to eq(totals)
        end
      end
    end
  end
end
