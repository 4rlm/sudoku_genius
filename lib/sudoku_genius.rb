require "sudoku_genius/version"

require "sudoku_genius/solver"
# require 'mechanizer'
# require 'scrub_db'
require 'pry'

module SudokuGenius

  def self.play(args={})
    results = self::Solver.new.play(args)
  end

end
