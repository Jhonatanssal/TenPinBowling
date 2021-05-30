# frozen_string_literal: true

require_relative './player'

# Bowling Methods
class Bowling
  def initialize
    @arr = []
    @arr2 = []
    @players = []
  end

  def file_input
    puts 'What is the name of the file to read?'
    file = gets.chomp
    File.open(file, 'r') do |f|
      f.each_line do |line|
        val = line.split(' ')[1].to_i
        p "ERROR: Please check your line '#{line[0..-2]}'" if val > 10 || val.negative?

        @arr << line.split(' ')
        @arr2 << line.split(' ')[0]
      end
    end
  end

  def number_of_players
    @arr2.uniq.count
  end

  def scores_array
    @arr
  end

  def create_players
    number_of_players.times do |n|
      player = Player.new(@arr2.uniq[n])
      @players << player
    end

    @players
  end

  def frame_name(player)
    puts player.name.capitalize
  end

  def put_spare_sign(arr)
    if arr.map(&:to_i).sum == 10
      print "#{arr[0]}   /   "
    else
      arr.each { |x| print "#{x}   " }
    end
  end

  def frame_pinfalls(player)
    print "Pinfalls\t"
    player.set_scores(@arr, number_of_players).each do |s|
      if s.length > 1
        put_spare_sign(s)
      else
        s.each { |_x| print '    X   ' }
      end
    end
    puts
  end

  def frame_scores(player)
    print "Score\t\t"
    player.total_scores(player.set_scores(@arr, number_of_players)).each { |s| print "#{s}\t" }
    puts
  end

  def frame
    create_players

    puts "Frame\t\t1\t2\t3\t4\t5\t6\t7\t8\t9\t10\t"
    @players.each do |player|
      frame_name(player)
      frame_pinfalls(player)
      frame_scores(player)
    end
  end
end
