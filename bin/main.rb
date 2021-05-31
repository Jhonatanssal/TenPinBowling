# frozen_string_literal: true

require_relative '../lib/player'
require_relative '../lib/bowling'

# Get input from user
puts 'What is the name of the file to read?'
file = gets.chomp

# Run Bowling class
a = Bowling.new(file)
a.play
