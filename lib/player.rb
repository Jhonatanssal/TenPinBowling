# frozen_string_literal: true

# Playes Methods
class Player
  def initialize(name)
    @player = {}
    @player[:name] = name
    @player[:pinfalls] = []
    @player[:totals] = []
  end

  def name
    @player[:name]
  end

  def set_scores(arr, number_of_players)
    len = number_of_players > 1 ? arr.length - 1 : arr.length
    temparr = []
    i = 0

    while i < len
      if arr[i][0] == @player[:name] && arr[i + 1][0] == @player[:name]
        if arr[i][1].to_i != 10
          temparr << [arr[i][1], arr[i + 1][1]]
          i += 2
        else
          temparr << [arr[i][1]]
          i += 1
        end
      elsif arr[i][0] == @player[:name] && arr[i + 1][0] != @player[:name]
        temparr << [arr[i][1]]
        i += 1
      else
        i += 1
      end
    end

    len2 = temparr.length
    first_nine = temparr[0..8]
    last_with_two = (temparr[9] + temparr[10]) if len2 == 11
    last_with_three = (temparr[9] + temparr[10] + temparr[11]) if len2 == 12

    @player[:pinfalls] = if len2 == 10
                           temparr
                         else
                           first_nine << (len2 == 11 ? last_with_two : last_with_three)
                         end
    @player[:pinfalls]
  end

  def total_scores(scores)
    scores_array = scores.map { |x| x.map(&:to_i) }
    total = 0
    i = 0

    while i < scores_array.length - 1
      if scores_array[i][0] == 10
        num = scores_array[i + 1][1].nil? ? scores_array[i + 2][0].to_i : scores_array[i + 1][1].to_i
        total += 10 + scores_array[i + 1][0].to_i + num
      elsif scores_array[i].sum == 10
        total += scores_array[i].sum + scores_array[i + 1][0]
      else
        total += scores_array[i].sum
      end
      @player[:totals] << total
      i += 1
    end
    total += scores_array[-1].sum

    @player[:totals] << total
  end
end
