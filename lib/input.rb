# frozen_string_literal: true

require_relative './errors'

class Input
  def initialize
    @error_messages = Errors.new
  end

  def get_file_info(file = '')
    @file = file if file != ''
    File.open(@file, 'r') do |f|
      arr = []
      names_arr = []
      f.each_line do |line|
        val = line.split(' ')[1].to_i
        @error_messages.value_errors(val, line)

        arr << line.split(' ')
        names_arr << line.split(' ')[0]
      end
      [arr, names_arr.uniq]
    end
  end
end
