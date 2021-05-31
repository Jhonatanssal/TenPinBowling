# frozen_string_literal: true

require_relative './player'

# Bowling Methods
class Bowling
  def initialize
    @arr = []
    @names_arr = []
    @players = []
    @file = ''
  end

  # Gets the name of the file to read
  def file_input
    puts 'What is the name of the file to read?'
    @file = gets.chomp
  end

  # Gets the info of the file and saves it inside two arrays
  def get_file_info(file = '')
    @file = file if file != ''
    File.open(@file, 'r') do |f|
      arr = []
      names_arr = []
      f.each_line do |line|
        val = line.split(' ')[1].to_i
        if val > 10 || val.negative?
          p "ERROR: Please check your line '#{line[0..-2]}'"
          exit
        end

        arr << line.split(' ')
        names_arr << line.split(' ')[0]
      end
      [arr, names_arr.uniq]
    end
  end

  # Saves file info in class variables
  def define_arrays
    @arr = get_file_info[0]
    @names_arr = get_file_info[1]
  end

  # Error
  def error(players)
    players.each_with_index do |player, i|
      scores = player.set_scores(@arr, @names_arr.length)
      last_turn = scores[-1]
      if scores[0...-1].length != 9 || last_turn.length > 3 || scores[i].length > 2
        p 'BAD INPUT: Please check your file.'
        exit
      elsif last_turn.length == 3 && (last_turn[0].to_i != 10 && last_turn[0].to_i + last_turn[1].to_i != 10)
        p 'BAD INPUT (FINAL TURN DOES NOT FOLLOW THE RULES): Please check your file.'
        exit
      end
    end
  end

  # Create players from Player class
  def create_players(names_arr)
    players = []
    names_arr.length.times do |n|
      player = Player.new(@names_arr[n])
      players << player
    end
    error(players)
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
    scores = player.set_scores(@arr, @names_arr.length)
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
    player.total_scores(player.set_scores(@arr, @names_arr.length)).each { |s| print "#{s}\t" }
    puts
  end

  # Prints entire frame
  def frame
    create_players(@names_arr)

    puts "Frame\t\t1\t2\t3\t4\t5\t6\t7\t8\t9\t10\t"
    @players.each do |player|
      frame_name(player)
      frame_pinfalls(player)
      frame_scores(player)
    end
  end

  # Prints frame with all of the Information
  def play
    file_input
    get_file_info
    define_arrays
    save_players
    frame
  end
end
