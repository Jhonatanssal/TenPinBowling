#!/usr/bin/env ruby

require_relative '../lib/player.rb'

# Read .txt document 
  # Separate scores by name inside two different arrays
arr = []
arr2 = []
scores1 = []
scores2 = []
puts "What is the name of the file to read?"
file = gets.chomp
File.open(file, "r") do |f|
  f.each_line {|line|
    arr << line.split(' ')
    arr2 << line.split(' ')[0]
  }
end

arr.each do |e|
  if e[0] == arr2.uniq[0]
    scores1 << e[1]
  else
    scores2 << e[1]
  end
end
scores = [scores1, scores2]

number_of_players = arr2.uniq.count
players_arr = []

number_of_players.times do |n|
  player = Player.new
  players_arr << [player.name(arr2[n]), player.set_scores(scores[n]), player.total_scores(player.set_scores(scores[n]))]
end

def frame(players_arr)
  puts "Frame\t\t1\t2\t3\t4\t5\t6\t7\t8\t9\t10\t"
  players_arr.each do |player|
    puts player[0]
    print "Pinfalls\t"
    player[1].each { |s| print "#{s[0].to_s}   #{s[1].to_s}   " }
    puts
    puts "Score\t\t10\t20\t30\t40\t50\t60\t70\t80\t90\t100"
  end
end

# frame()
print players_arr[1]
# frame(players_arr)
# print separate_players(arr)
puts