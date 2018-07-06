
module SudokuGenius
  class Solver

    def initialize
      binding.pry
    end

    def start
      binding.pry
      "testing setup"
    end

    #
    # def self.refresh_values
    #   @starting_dash_count = 0
    #   @ending_dash_count = 0
    #   @starting_board = nil
    #   @final_board = []
    #   @solved = nil
    #   @start_time = Time.now
    # end
    #
    # # AlgoService.new.run_sudoku
    # def self.run_sudoku
    #   sudoku_scores = []
    #   puzzle_strings = File.readlines('services_bin/algos/sudoku_puzzles.txt')
    #   total_rounds = puzzle_strings.count
    #
    #   totals = puzzle_strings.enum_for(:each_with_index).map do |puzzle,i|
    #     refresh_values
    #     starting_board = format_puzzle_string(puzzle)
    #     starting_dash_count = get_dash_count_totals(starting_board)
    #     start_puzzle(puzzle)
    #
    #     unless @solved == nil
    #       sudoku_scores << { round: i+1,
    #               rounds: total_rounds,
    #               solved: @solved,
    #               starting_board: remove_quotes(starting_board),
    #               final_board: remove_quotes(@final_board),
    #               duration: Time.now - @start_time,
    #               starting_dash_count: starting_dash_count,
    #               ending_dash_count: ending_dash_count = get_dash_count_totals(@final_board)
    #             }
    #
    #     end
    #   end
    #   return sudoku_scores.reverse
    # end
    #
    # def self.remove_quotes(rows)
    #   rows.map! do |row|
    #     row.map { |el| number_or_nil(el) }
    #   end
    # end
    #
    # def self.number_or_nil(string)
    #   num = string.to_i
    #   num.to_s == string ? num : string
    # end
    #
    # def self.format_puzzle_string(puzzle_string)
    #   rows = puzzle_string.chomp.chars.each_slice(9).to_a
    # end
    #
    # def self.start_puzzle(puzzle_string)
    #   rows = format_puzzle_string(puzzle_string)
    #   data_hashes = find_dash_options(make_data_hash(rows))
    #   updated_rows = fill_dashes(data_hashes, rows)
    #   @final_board = updated_rows if !@final_board.any?
    #   looper(puzzle_string, updated_rows)
    # end
    #
    # def self.get_dash_count_totals(rows)
    #   total_dash_count = rows.flatten.join.count "-"
    # end
    #
    # def self.looper(puzzle_string, updated_rows)
    #   starting_dash_count = get_dash_count_totals(updated_rows)
    #   return solved?(updated_rows) if starting_dash_count == 0
    #   data_hashes = find_dash_options(make_data_hash(updated_rows))
    #   updated_rows = fill_dashes(data_hashes, updated_rows)
    #   ending_dash_count = get_dash_count_totals(updated_rows)
    #   return solved?(updated_rows) if ending_dash_count == 0
    #
    #   (ending_dash_count != starting_dash_count) ? looper(puzzle_string, updated_rows) : looper(puzzle_string, format_puzzle_string(puzzle_string))
    # end
    #
    # def self.find_column(rows)
    #   rows[0..-1].transpose.to_a
    # end
    #
    # def self.find_dash_coords(rows)
    #   coords = []
    #   rows.each do |row|
    #     if row.include?("-")
    #       for col in 0...row.length
    #         coords << [rows.index(row), col] if row[col] == '-'
    #       end
    #     end
    #   end
    #   coords
    # end
    #
    # def self.find_box(rows)
    #   boxes = [[]] * 9
    #   boxes[0] = rows[0][0..2]+rows[1][0..2]+rows[2][0..2]
    #   boxes[1] = rows[0][3..5]+rows[1][3..5]+rows[2][3..5]
    #   boxes[2] = rows[0][6..8]+rows[1][6..8]+rows[2][6..8]
    #   boxes[3] = rows[3][0..2]+rows[4][0..2]+rows[5][0..2]
    #   boxes[4] = rows[3][3..5]+rows[4][3..5]+rows[5][3..5]
    #   boxes[5] = rows[3][6..8]+rows[4][6..8]+rows[5][6..8]
    #   boxes[6] = rows[6][0..2]+rows[7][0..2]+rows[8][0..2]
    #   boxes[7] = rows[6][3..5]+rows[7][3..5]+rows[8][3..5]
    #   boxes[8] = rows[6][6..8]+rows[7][6..8]+rows[8][6..8]
    #   boxes
    # end
    #
    # def self.make_data_hash(rows)
    #   cols = find_column(rows)
    #   all_dash_coords = find_dash_coords(rows)
    #   boxes = find_box(rows)
    #
    #   data = []
    #
    #   all_dash_coords.each do |coords|
    #     r_i = coords[0]
    #     c_i = coords[1]
    #
    #     data_hash = {coords: coords, row: rows[r_i], col: cols[c_i]  }
    #
    #     if (0..2) === r_i && (0..2) === c_i
    #       data_hash[:box] = boxes[0]
    #     elsif (0..2) === r_i && (3..5) === c_i
    #       data_hash[:box] = boxes[1]
    #     elsif (0..2) === r_i && (6..8) === c_i
    #       data_hash[:box] = boxes[2]
    #     elsif (3..5) === r_i && (0..2) === c_i
    #       data_hash[:box] = boxes[3]
    #     elsif (3..5) === r_i && (3..5) === c_i
    #       data_hash[:box] = boxes[4]
    #     elsif (3..5) === r_i && (6..8) === c_i
    #       data_hash[:box] = boxes[5]
    #     elsif (6..8) === r_i && (0..2) === c_i
    #       data_hash[:box] = boxes[6]
    #     elsif (6..8) === r_i && (3..5) === c_i
    #       data_hash[:box] = boxes[7]
    #     elsif (6..8) === r_i && (6..8) === c_i
    #       data_hash[:box] = boxes[8]
    #     end
    #     data << data_hash
    #   end
    #   data
    # end
    #
    # def self.find_dash_options(data_hashes)
    #   all_numbers = (1..9).to_a
    #   data_hashes.each do |data_hash|
    #     numbers_played = data_hash[:row] + data_hash[:col] + data_hash[:box]
    #     numbers_played.uniq!.delete("-")
    #     options = all_numbers - numbers_played.map!(&:to_i)
    #     data_hash[:options] = options
    #   end
    # end
    #
    # def self.get_lowest_option_count_hash(data_hashes)
    #   counter = 0
    #   lowest_option_count_hash = nil
    #   while !lowest_option_count_hash && counter < 10
    #     counter += 1
    #     lowest_option_count_hash = data_hashes.find { |hash| hash[:options].count == counter }
    #   end
    #   lowest_option_count_hash
    # end
    #
    # def self.fill_dashes(data_hashes, rows)
    #   lowest_option_count_hash = get_lowest_option_count_hash(data_hashes)
    #
    #   if !lowest_option_count_hash.nil?
    #     lowest_option_count = lowest_option_count_hash[:options].count
    #
    #     if lowest_option_count == 1 ## fill dashes if only one option available.
    #       data_hashes.each do |data_hash|
    #         r_i = data_hash[:coords][0]
    #         c_i = data_hash[:coords][1]
    #         rows[r_i][c_i] = data_hash[:options].first if data_hash[:options].count == 1
    #       end
    #     end
    #
    #     if lowest_option_count > 1
    #       r_i = lowest_option_count_hash[:coords][0]
    #       c_i = lowest_option_count_hash[:coords][1]
    #       rows[r_i][c_i] = lowest_option_count_hash[:options].sample
    #     end
    #
    #   end
    #   rows
    # end
    #
    #
    # def self.solved?(board)
    #   puts "\n\n#{"="*25}\nThe board was solved!\n\n"
    #   puts pretty_board(board)
    #   @solved = true
    #   return @solved
    # end
    #
    #
    # def self.pretty_board(board)
    #   pretty_rows = board.map { |row| row.join('  ') }
    #   pretty_rows.map! { |row| row.insert(-1, "\n") }
    # end


  end
end
