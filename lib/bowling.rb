# frozen_string_literal: true

require_relative './player'
require_relative './errors'
require_relative './input'

# Bowling Class
class Bowling
  def initialize(file = '')
    @arr = []
    @names_arr = []
    @players = []
    @file = file
    @error_messages = Errors.new
    @input = Input.new
  end

  # Saves file info in class variables
  def define_arrays
    file_input = @input.get_file_info(@file)
    @arr = file_input[0]
    @names_arr = file_input[1]
  end

  # Create players from Player class
  def create_players(names_arr)
    players = []
    names_arr.length.times do |n|
      player = Player.new(names_arr[n])
      players << player
    end
    players
  end

  # Saves player instances on class variable
  def save_players
    @players = create_players(@names_arr)
  end

  # Sets header of Frame
  def frame_name(player)
    puts player.name.capitalize
  end

  # Defines Spare signs
  def put_spare_sign(arr)
    if arr.map(&:to_i).sum == 10
      print "#{arr[0]}   /   "
    else
      arr.each { |x| print "#{x}   " }
    end
  end

  # Prints last turn's pinfalls
  def last_turn_pinfalls(arr)
    arr.length.times do |t|
      if arr[t].to_i == 10
        print 'X   '
      elsif arr[t].to_i + arr[t + 1].to_i == 10
        print "#{arr[t]}   /   #{arr[t + 2]}"
        break
      else
        print "#{arr[t]}   "
      end
    end
  end

  # Prints first 9 pinfalls line on the frame
  def frame_pinfalls(player)
    print "Pinfalls\t"
    scores = player.set_scores(@arr, @names_arr.length, player.name)
    scores[0...-1].each do |s|
      if s.length > 1
        put_spare_sign(s)
      else
        s.each { |_x| print '    X   ' }
      end
    end
    last_turn_pinfalls(scores[-1])
    puts
  end

  # Prints scores line on the frame
  def frame_scores(player)
    print "Score\t\t"
    player.total_scores(player.set_scores(@arr, @names_arr.length, player.name)).each { |s| print "#{s}\t" }
    puts
  end

  # Prints entire frame
  def frame
    create_players(@names_arr)
    @error_messages.turn_errors(@players, @arr, @names_arr)

    puts "Frame\t\t1\t2\t3\t4\t5\t6\t7\t8\t9\t10\t"
    @players.each do |player|
      frame_name(player)
      frame_pinfalls(player)
      frame_scores(player)
    end
  end

  # Prints frame with all of the Information
  def play
    define_arrays
    save_players
    frame
  end
end
