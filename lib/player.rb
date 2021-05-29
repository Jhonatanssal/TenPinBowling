class Player
  def inizialize
  end

  def name(name)
    name
  end

  def set_scores(scores)
    scores_array = []
    i = 0
    while i < scores.length - 3 do
      if scores[i].to_i != 10
        scores_array << [scores[i].to_i, scores[i + 1].to_i]
        i += 2
      else
        scores_array << [10]
        i += 1
      end
    end
    scores_array << scores.slice(scores.length - 3, scores.length).map(&:to_i)
  end

  def total_scores(scores)
    total_array = []
    total = 0
    i = 0
    while i < scores.length - 1 do
      if scores[i].include? 10
        total += 10 + scores[i + 1][0].to_i + (scores[i + 1][1].nil? ? scores[i + 2][0] : scores[i + 1][1])
      elsif scores[i].sum == 10
        total += scores[i].sum + scores[i + 1][0]
      else
        total += scores[i].sum
      end
      total_array << total
      i += 1
    end
    total_array << total += scores[-1].sum
  end
end