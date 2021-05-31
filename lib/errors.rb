# frozen_string_literal: true

class Errors
  def turn_errors(players, arr, names_arr)
    players.each do |player|
      scores = player.set_scores(arr, names_arr.length, player.name)
      last_turn = scores[-1]
      if scores.length > 12 || last_turn.length > 3 || scores[0...-2].any? { |i| i.length >= 3 }
        p 'BAD INPUT: Please check your file.'
        exit
      elsif last_turn.length == 3 && (last_turn[0].to_i != 10 && last_turn[0].to_i + last_turn[1].to_i != 10)
        p 'BAD INPUT (FINAL TURN DOES NOT FOLLOW THE RULES): Please check your file.'
        exit
      end
    end
  end

  def value_errors(val, line)
    return unless val > 10 || val.negative?
    p "ERROR: Please check your line '#{line[0..-2]}'"
    exit
  end
end
