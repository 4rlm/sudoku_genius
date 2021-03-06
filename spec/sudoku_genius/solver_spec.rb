# rspec spec/sudoku_genius/solver_spec.rb

require 'spec_helper'

describe 'Solver' do
  let(:solver_obj) { SudokuGenius::Solver.new }
  # before { solver_obj.inst = inst }

  let(:rows) do
    [
      ['1', '-', '5', '8', '-', '2', '-', '-', '-'],
      ['-', '9', '-', '-', '7', '6', '4', '-', '5'],
      ['2', '-', '-', '4', '-', '-', '8', '1', '9'],
      ['-', '1', '9', '-', '-', '7', '3', '-', '6'],
      ['7', '6', '2', '-', '8', '3', '-', '9', '-'],
      ['-', '-', '-', '-', '6', '1', '-', '5', '-'],
      ['-', '-', '7', '6', '-', '-', '-', '3', '-'],
      ['4', '3', '-', '-', '2', '-', '5', '-', '1'],
      ['6', '-', '-', '3', '-', '8', '9', '-', '-']
    ]
  end

  let(:updated_rows) do
    [
      ['1', '-', '5', '8', '-', '2', '-', '-', '-'],
      ['-', '9', '-', 1, '7', '6', '4', 2, '5'],
      ['2', 7, '-', '4', '-', 5, '8', '1', '9'],
      ['-', '1', '9', '-', '-', '7', '3', '-', '6'],
      ['7', '6', '2', 5, '8', '3', 1, '9', 4],
      ['-', '-', '-', '-', '6', '1', '-', '5', '-'],
      ['-', '-', '7', '6', '-', '-', 2, '3', '-'],
      ['4', '3', 8, '-', '2', 9, '5', '-', '1'],
      ['6', '-', 1, '3', '-', '8', '9', '-', '-']
    ]
  end

  let(:formatted_rows) do
    [
      ['1', '-', '5', '8', '-', '2', '-', '-', '-'],
      ['-', '9', '-', '-', '7', '6', '4', '-', '5'],
      ['2', '-', '-', '4', '-', '-', '8', '1', '9'],
      ['-', '1', '9', '-', '-', '7', '3', '-', '6'],
      ['7', '6', '2', '-', '8', '3', '-', '9', '-'],
      ['-', '-', '-', '-', '6', '1', '-', '5', '-'],
      ['-', '-', '7', '6', '-', '-', '-', '3', '-'],
      ['4', '3', '-', '-', '2', '-', '5', '-', '1'],
      ['6', '-', '-', '3', '-', '8', '9', '-', '-']
    ]
  end

  let(:board) do
    [
      ['1', 4, '5', '8', 9, '2', 6, 7, 3],
      [8, '9', 3, 1, '7', '6', '4', 2, '5'],
      ['2', 7, 6, '4', 3, 5, '8', '1', '9'],
      [5, '1', '9', 2, 4, '7', '3', 8, '6'],
      ['7', '6', '2', 5, '8', '3', 1, '9', 4],
      [3, 8, 4, 9, '6', '1', 7, '5', 2],
      [9, 5, '7', '6', 1, 4, 2, '3', 8],
      ['4', '3', 8, 7, '2', 9, '5', 6, '1'],
      ['6', 2, 1, '3', 5, '8', '9', 4, 7]
    ]
  end

  let(:data_hashes) do
    [
      { coords: [0, 1],
        row: ['1', '-', '5', '8', '-', '2', '-', '-', '-'],
        col: ['-', '9', '-', '1', '6', '-', '-', '3', '-'],
        box: ['1', '-', '5', '-', '9', '-', '2', '-', '-'] },
      { coords: [0, 4],
        row: ['1', '-', '5', '8', '-', '2', '-', '-', '-'],
        col: ['-', '7', '-', '-', '8', '6', '-', '2', '-'],
        box: ['8', '-', '2', '-', '7', '6', '4', '-', '-'] },
      { coords: [0, 6],
        row: ['1', '-', '5', '8', '-', '2', '-', '-', '-'],
        col: ['-', '4', '8', '3', '-', '-', '-', '5', '9'],
        box: ['-', '-', '-', '4', '-', '5', '8', '1', '9'] },
      { coords: [0, 7],
        row: ['1', '-', '5', '8', '-', '2', '-', '-', '-'],
        col: ['-', '-', '1', '-', '9', '5', '3', '-', '-'],
        box: ['-', '-', '-', '4', '-', '5', '8', '1', '9'] },
      { coords: [0, 8],
        row: ['1', '-', '5', '8', '-', '2', '-', '-', '-'],
        col: ['-', '5', '9', '6', '-', '-', '-', '1', '-'],
        box: ['-', '-', '-', '4', '-', '5', '8', '1', '9'] },
      { coords: [1, 0],
        row: ['-', '9', '-', '-', '7', '6', '4', '-', '5'],
        col: ['1', '-', '2', '-', '7', '-', '-', '4', '6'],
        box: ['1', '-', '5', '-', '9', '-', '2', '-', '-'] },
      { coords: [1, 2],
        row: ['-', '9', '-', '-', '7', '6', '4', '-', '5'],
        col: ['5', '-', '-', '9', '2', '-', '7', '-', '-'],
        box: ['1', '-', '5', '-', '9', '-', '2', '-', '-'] },
      { coords: [1, 3],
        row: ['-', '9', '-', '-', '7', '6', '4', '-', '5'],
        col: ['8', '-', '4', '-', '-', '-', '6', '-', '3'],
        box: ['8', '-', '2', '-', '7', '6', '4', '-', '-'] },
      { coords: [1, 7],
        row: ['-', '9', '-', '-', '7', '6', '4', '-', '5'],
        col: ['-', '-', '1', '-', '9', '5', '3', '-', '-'],
        box: ['-', '-', '-', '4', '-', '5', '8', '1', '9'] },
      { coords: [2, 1],
        row: ['2', '-', '-', '4', '-', '-', '8', '1', '9'],
        col: ['-', '9', '-', '1', '6', '-', '-', '3', '-'],
        box: ['1', '-', '5', '-', '9', '-', '2', '-', '-'] },
      { coords: [2, 2],
        row: ['2', '-', '-', '4', '-', '-', '8', '1', '9'],
        col: ['5', '-', '-', '9', '2', '-', '7', '-', '-'],
        box: ['1', '-', '5', '-', '9', '-', '2', '-', '-'] },
      { coords: [2, 4],
        row: ['2', '-', '-', '4', '-', '-', '8', '1', '9'],
        col: ['-', '7', '-', '-', '8', '6', '-', '2', '-'],
        box: ['8', '-', '2', '-', '7', '6', '4', '-', '-'] },
      { coords: [2, 5],
        row: ['2', '-', '-', '4', '-', '-', '8', '1', '9'],
        col: ['2', '6', '-', '7', '3', '1', '-', '-', '8'],
        box: ['8', '-', '2', '-', '7', '6', '4', '-', '-'] },
      { coords: [3, 0],
        row: ['-', '1', '9', '-', '-', '7', '3', '-', '6'],
        col: ['1', '-', '2', '-', '7', '-', '-', '4', '6'],
        box: ['-', '1', '9', '7', '6', '2', '-', '-', '-'] },
      { coords: [3, 3],
        row: ['-', '1', '9', '-', '-', '7', '3', '-', '6'],
        col: ['8', '-', '4', '-', '-', '-', '6', '-', '3'],
        box: ['-', '-', '7', '-', '8', '3', '-', '6', '1'] },
      { coords: [3, 4],
        row: ['-', '1', '9', '-', '-', '7', '3', '-', '6'],
        col: ['-', '7', '-', '-', '8', '6', '-', '2', '-'],
        box: ['-', '-', '7', '-', '8', '3', '-', '6', '1'] },
      { coords: [3, 7],
        row: ['-', '1', '9', '-', '-', '7', '3', '-', '6'],
        col: ['-', '-', '1', '-', '9', '5', '3', '-', '-'],
        box: ['3', '-', '6', '-', '9', '-', '-', '5', '-'] },
      { coords: [4, 3],
        row: ['7', '6', '2', '-', '8', '3', '-', '9', '-'],
        col: ['8', '-', '4', '-', '-', '-', '6', '-', '3'],
        box: ['-', '-', '7', '-', '8', '3', '-', '6', '1'] },
      { coords: [4, 6],
        row: ['7', '6', '2', '-', '8', '3', '-', '9', '-'],
        col: ['-', '4', '8', '3', '-', '-', '-', '5', '9'],
        box: ['3', '-', '6', '-', '9', '-', '-', '5', '-'] },
      { coords: [4, 8],
        row: ['7', '6', '2', '-', '8', '3', '-', '9', '-'],
        col: ['-', '5', '9', '6', '-', '-', '-', '1', '-'],
        box: ['3', '-', '6', '-', '9', '-', '-', '5', '-'] },
      { coords: [5, 0],
        row: ['-', '-', '-', '-', '6', '1', '-', '5', '-'],
        col: ['1', '-', '2', '-', '7', '-', '-', '4', '6'],
        box: ['-', '1', '9', '7', '6', '2', '-', '-', '-'] },
      { coords: [5, 1],
        row: ['-', '-', '-', '-', '6', '1', '-', '5', '-'],
        col: ['-', '9', '-', '1', '6', '-', '-', '3', '-'],
        box: ['-', '1', '9', '7', '6', '2', '-', '-', '-'] },
      { coords: [5, 2],
        row: ['-', '-', '-', '-', '6', '1', '-', '5', '-'],
        col: ['5', '-', '-', '9', '2', '-', '7', '-', '-'],
        box: ['-', '1', '9', '7', '6', '2', '-', '-', '-'] },
      { coords: [5, 3],
        row: ['-', '-', '-', '-', '6', '1', '-', '5', '-'],
        col: ['8', '-', '4', '-', '-', '-', '6', '-', '3'],
        box: ['-', '-', '7', '-', '8', '3', '-', '6', '1'] },
      { coords: [5, 6],
        row: ['-', '-', '-', '-', '6', '1', '-', '5', '-'],
        col: ['-', '4', '8', '3', '-', '-', '-', '5', '9'],
        box: ['3', '-', '6', '-', '9', '-', '-', '5', '-'] },
      { coords: [5, 8],
        row: ['-', '-', '-', '-', '6', '1', '-', '5', '-'],
        col: ['-', '5', '9', '6', '-', '-', '-', '1', '-'],
        box: ['3', '-', '6', '-', '9', '-', '-', '5', '-'] },
      { coords: [6, 0],
        row: ['-', '-', '7', '6', '-', '-', '-', '3', '-'],
        col: ['1', '-', '2', '-', '7', '-', '-', '4', '6'],
        box: ['-', '-', '7', '4', '3', '-', '6', '-', '-'] },
      { coords: [6, 1],
        row: ['-', '-', '7', '6', '-', '-', '-', '3', '-'],
        col: ['-', '9', '-', '1', '6', '-', '-', '3', '-'],
        box: ['-', '-', '7', '4', '3', '-', '6', '-', '-'] },
      { coords: [6, 4],
        row: ['-', '-', '7', '6', '-', '-', '-', '3', '-'],
        col: ['-', '7', '-', '-', '8', '6', '-', '2', '-'],
        box: ['6', '-', '-', '-', '2', '-', '3', '-', '8'] },
      { coords: [6, 5],
        row: ['-', '-', '7', '6', '-', '-', '-', '3', '-'],
        col: ['2', '6', '-', '7', '3', '1', '-', '-', '8'],
        box: ['6', '-', '-', '-', '2', '-', '3', '-', '8'] },
      { coords: [6, 6],
        row: ['-', '-', '7', '6', '-', '-', '-', '3', '-'],
        col: ['-', '4', '8', '3', '-', '-', '-', '5', '9'],
        box: ['-', '3', '-', '5', '-', '1', '9', '-', '-'] },
      { coords: [6, 8],
        row: ['-', '-', '7', '6', '-', '-', '-', '3', '-'],
        col: ['-', '5', '9', '6', '-', '-', '-', '1', '-'],
        box: ['-', '3', '-', '5', '-', '1', '9', '-', '-'] },
      { coords: [7, 2],
        row: ['4', '3', '-', '-', '2', '-', '5', '-', '1'],
        col: ['5', '-', '-', '9', '2', '-', '7', '-', '-'],
        box: ['-', '-', '7', '4', '3', '-', '6', '-', '-'] },
      { coords: [7, 3],
        row: ['4', '3', '-', '-', '2', '-', '5', '-', '1'],
        col: ['8', '-', '4', '-', '-', '-', '6', '-', '3'],
        box: ['6', '-', '-', '-', '2', '-', '3', '-', '8'] },
      { coords: [7, 5],
        row: ['4', '3', '-', '-', '2', '-', '5', '-', '1'],
        col: ['2', '6', '-', '7', '3', '1', '-', '-', '8'],
        box: ['6', '-', '-', '-', '2', '-', '3', '-', '8'] },
      { coords: [7, 7],
        row: ['4', '3', '-', '-', '2', '-', '5', '-', '1'],
        col: ['-', '-', '1', '-', '9', '5', '3', '-', '-'],
        box: ['-', '3', '-', '5', '-', '1', '9', '-', '-'] },
      { coords: [8, 1],
        row: ['6', '-', '-', '3', '-', '8', '9', '-', '-'],
        col: ['-', '9', '-', '1', '6', '-', '-', '3', '-'],
        box: ['-', '-', '7', '4', '3', '-', '6', '-', '-'] },
      { coords: [8, 2],
        row: ['6', '-', '-', '3', '-', '8', '9', '-', '-'],
        col: ['5', '-', '-', '9', '2', '-', '7', '-', '-'],
        box: ['-', '-', '7', '4', '3', '-', '6', '-', '-'] },
      { coords: [8, 4],
        row: ['6', '-', '-', '3', '-', '8', '9', '-', '-'],
        col: ['-', '7', '-', '-', '8', '6', '-', '2', '-'],
        box: ['6', '-', '-', '-', '2', '-', '3', '-', '8'] },
      { coords: [8, 7],
        row: ['6', '-', '-', '3', '-', '8', '9', '-', '-'],
        col: ['-', '-', '1', '-', '9', '5', '3', '-', '-'],
        box: ['-', '3', '-', '5', '-', '1', '9', '-', '-'] },
      { coords: [8, 8],
        row: ['6', '-', '-', '3', '-', '8', '9', '-', '-'],
        col: ['-', '5', '9', '6', '-', '-', '-', '1', '-'],
        box: ['-', '3', '-', '5', '-', '1', '9', '-', '-'] }
    ]
  end

  let(:option_hashes) do
    [
      {:coords=>[0, 1],
  :row=>["1", "-", "5", "8", "-", "2", "-", "-", "-"],
  :col=>["-", "9", "-", "1", "6", "-", "-", "3", "-"],
  :box=>["1", "-", "5", "-", "9", "-", "2", "-", "-"],
  :options=>[4, 7]},
 {:coords=>[0, 4],
  :row=>["1", "-", "5", "8", "-", "2", "-", "-", "-"],
  :col=>["-", "7", "-", "-", "8", "6", "-", "2", "-"],
  :box=>["8", "-", "2", "-", "7", "6", "4", "-", "-"],
  :options=>[3, 9]},
 {:coords=>[0, 6],
  :row=>["1", "-", "5", "8", "-", "2", "-", "-", "-"],
  :col=>["-", "4", "8", "3", "-", "-", "-", "5", "9"],
  :box=>["-", "-", "-", "4", "-", "5", "8", "1", "9"],
  :options=>[6, 7]},
 {:coords=>[0, 7],
  :row=>["1", "-", "5", "8", "-", "2", "-", "-", "-"],
  :col=>["-", "-", "1", "-", "9", "5", "3", "-", "-"],
  :box=>["-", "-", "-", "4", "-", "5", "8", "1", "9"],
  :options=>[6, 7]},
 {:coords=>[0, 8],
  :row=>["1", "-", "5", "8", "-", "2", "-", "-", "-"],
  :col=>["-", "5", "9", "6", "-", "-", "-", "1", "-"],
  :box=>["-", "-", "-", "4", "-", "5", "8", "1", "9"],
  :options=>[3, 7]},
 {:coords=>[1, 0],
  :row=>["-", "9", "-", "-", "7", "6", "4", "-", "5"],
  :col=>["1", "-", "2", "-", "7", "-", "-", "4", "6"],
  :box=>["1", "-", "5", "-", "9", "-", "2", "-", "-"],
  :options=>[3, 8]},
 {:coords=>[1, 2],
  :row=>["-", "9", "-", "-", "7", "6", "4", "-", "5"],
  :col=>["5", "-", "-", "9", "2", "-", "7", "-", "-"],
  :box=>["1", "-", "5", "-", "9", "-", "2", "-", "-"],
  :options=>[3, 8]},
 {:coords=>[1, 3],
  :row=>["-", "9", "-", "-", "7", "6", "4", "-", "5"],
  :col=>["8", "-", "4", "-", "-", "-", "6", "-", "3"],
  :box=>["8", "-", "2", "-", "7", "6", "4", "-", "-"],
  :options=>[1]},
 {:coords=>[1, 7],
  :row=>["-", "9", "-", "-", "7", "6", "4", "-", "5"],
  :col=>["-", "-", "1", "-", "9", "5", "3", "-", "-"],
  :box=>["-", "-", "-", "4", "-", "5", "8", "1", "9"],
  :options=>[2]},
 {:coords=>[2, 1],
  :row=>["2", "-", "-", "4", "-", "-", "8", "1", "9"],
  :col=>["-", "9", "-", "1", "6", "-", "-", "3", "-"],
  :box=>["1", "-", "5", "-", "9", "-", "2", "-", "-"],
  :options=>[7]},
 {:coords=>[2, 2],
  :row=>["2", "-", "-", "4", "-", "-", "8", "1", "9"],
  :col=>["5", "-", "-", "9", "2", "-", "7", "-", "-"],
  :box=>["1", "-", "5", "-", "9", "-", "2", "-", "-"],
  :options=>[3, 6]},
 {:coords=>[2, 4],
  :row=>["2", "-", "-", "4", "-", "-", "8", "1", "9"],
  :col=>["-", "7", "-", "-", "8", "6", "-", "2", "-"],
  :box=>["8", "-", "2", "-", "7", "6", "4", "-", "-"],
  :options=>[3, 5]},
 {:coords=>[2, 5],
  :row=>["2", "-", "-", "4", "-", "-", "8", "1", "9"],
  :col=>["2", "6", "-", "7", "3", "1", "-", "-", "8"],
  :box=>["8", "-", "2", "-", "7", "6", "4", "-", "-"],
  :options=>[5]},
 {:coords=>[3, 0],
  :row=>["-", "1", "9", "-", "-", "7", "3", "-", "6"],
  :col=>["1", "-", "2", "-", "7", "-", "-", "4", "6"],
  :box=>["-", "1", "9", "7", "6", "2", "-", "-", "-"],
  :options=>[5, 8]},
 {:coords=>[3, 3],
  :row=>["-", "1", "9", "-", "-", "7", "3", "-", "6"],
  :col=>["8", "-", "4", "-", "-", "-", "6", "-", "3"],
  :box=>["-", "-", "7", "-", "8", "3", "-", "6", "1"],
  :options=>[2, 5]},
 {:coords=>[3, 4],
  :row=>["-", "1", "9", "-", "-", "7", "3", "-", "6"],
  :col=>["-", "7", "-", "-", "8", "6", "-", "2", "-"],
  :box=>["-", "-", "7", "-", "8", "3", "-", "6", "1"],
  :options=>[4, 5]},
 {:coords=>[3, 7],
  :row=>["-", "1", "9", "-", "-", "7", "3", "-", "6"],
  :col=>["-", "-", "1", "-", "9", "5", "3", "-", "-"],
  :box=>["3", "-", "6", "-", "9", "-", "-", "5", "-"],
  :options=>[2, 4, 8]},
 {:coords=>[4, 3],
  :row=>["7", "6", "2", "-", "8", "3", "-", "9", "-"],
  :col=>["8", "-", "4", "-", "-", "-", "6", "-", "3"],
  :box=>["-", "-", "7", "-", "8", "3", "-", "6", "1"],
  :options=>[5]},
 {:coords=>[4, 6],
  :row=>["7", "6", "2", "-", "8", "3", "-", "9", "-"],
  :col=>["-", "4", "8", "3", "-", "-", "-", "5", "9"],
  :box=>["3", "-", "6", "-", "9", "-", "-", "5", "-"],
  :options=>[1]},
 {:coords=>[4, 8],
  :row=>["7", "6", "2", "-", "8", "3", "-", "9", "-"],
  :col=>["-", "5", "9", "6", "-", "-", "-", "1", "-"],
  :box=>["3", "-", "6", "-", "9", "-", "-", "5", "-"],
  :options=>[4]},
 {:coords=>[5, 0],
  :row=>["-", "-", "-", "-", "6", "1", "-", "5", "-"],
  :col=>["1", "-", "2", "-", "7", "-", "-", "4", "6"],
  :box=>["-", "1", "9", "7", "6", "2", "-", "-", "-"],
  :options=>[3, 8]},
 {:coords=>[5, 1],
  :row=>["-", "-", "-", "-", "6", "1", "-", "5", "-"],
  :col=>["-", "9", "-", "1", "6", "-", "-", "3", "-"],
  :box=>["-", "1", "9", "7", "6", "2", "-", "-", "-"],
  :options=>[4, 8]},
 {:coords=>[5, 2],
  :row=>["-", "-", "-", "-", "6", "1", "-", "5", "-"],
  :col=>["5", "-", "-", "9", "2", "-", "7", "-", "-"],
  :box=>["-", "1", "9", "7", "6", "2", "-", "-", "-"],
  :options=>[3, 4, 8]},
 {:coords=>[5, 3],
  :row=>["-", "-", "-", "-", "6", "1", "-", "5", "-"],
  :col=>["8", "-", "4", "-", "-", "-", "6", "-", "3"],
  :box=>["-", "-", "7", "-", "8", "3", "-", "6", "1"],
  :options=>[2, 9]},
 {:coords=>[5, 6],
  :row=>["-", "-", "-", "-", "6", "1", "-", "5", "-"],
  :col=>["-", "4", "8", "3", "-", "-", "-", "5", "9"],
  :box=>["3", "-", "6", "-", "9", "-", "-", "5", "-"],
  :options=>[2, 7]},
 {:coords=>[5, 8],
  :row=>["-", "-", "-", "-", "6", "1", "-", "5", "-"],
  :col=>["-", "5", "9", "6", "-", "-", "-", "1", "-"],
  :box=>["3", "-", "6", "-", "9", "-", "-", "5", "-"],
  :options=>[2, 4, 7, 8]},
 {:coords=>[6, 0],
  :row=>["-", "-", "7", "6", "-", "-", "-", "3", "-"],
  :col=>["1", "-", "2", "-", "7", "-", "-", "4", "6"],
  :box=>["-", "-", "7", "4", "3", "-", "6", "-", "-"],
  :options=>[5, 8, 9]},
 {:coords=>[6, 1],
  :row=>["-", "-", "7", "6", "-", "-", "-", "3", "-"],
  :col=>["-", "9", "-", "1", "6", "-", "-", "3", "-"],
  :box=>["-", "-", "7", "4", "3", "-", "6", "-", "-"],
  :options=>[2, 5, 8]},
 {:coords=>[6, 4],
  :row=>["-", "-", "7", "6", "-", "-", "-", "3", "-"],
  :col=>["-", "7", "-", "-", "8", "6", "-", "2", "-"],
  :box=>["6", "-", "-", "-", "2", "-", "3", "-", "8"],
  :options=>[1, 4, 5, 9]},
 {:coords=>[6, 5],
  :row=>["-", "-", "7", "6", "-", "-", "-", "3", "-"],
  :col=>["2", "6", "-", "7", "3", "1", "-", "-", "8"],
  :box=>["6", "-", "-", "-", "2", "-", "3", "-", "8"],
  :options=>[4, 5, 9]},
 {:coords=>[6, 6],
  :row=>["-", "-", "7", "6", "-", "-", "-", "3", "-"],
  :col=>["-", "4", "8", "3", "-", "-", "-", "5", "9"],
  :box=>["-", "3", "-", "5", "-", "1", "9", "-", "-"],
  :options=>[2]},
 {:coords=>[6, 8],
  :row=>["-", "-", "7", "6", "-", "-", "-", "3", "-"],
  :col=>["-", "5", "9", "6", "-", "-", "-", "1", "-"],
  :box=>["-", "3", "-", "5", "-", "1", "9", "-", "-"],
  :options=>[2, 4, 8]},
 {:coords=>[7, 2],
  :row=>["4", "3", "-", "-", "2", "-", "5", "-", "1"],
  :col=>["5", "-", "-", "9", "2", "-", "7", "-", "-"],
  :box=>["-", "-", "7", "4", "3", "-", "6", "-", "-"],
  :options=>[8]},
 {:coords=>[7, 3],
  :row=>["4", "3", "-", "-", "2", "-", "5", "-", "1"],
  :col=>["8", "-", "4", "-", "-", "-", "6", "-", "3"],
  :box=>["6", "-", "-", "-", "2", "-", "3", "-", "8"],
  :options=>[7, 9]},
 {:coords=>[7, 5],
  :row=>["4", "3", "-", "-", "2", "-", "5", "-", "1"],
  :col=>["2", "6", "-", "7", "3", "1", "-", "-", "8"],
  :box=>["6", "-", "-", "-", "2", "-", "3", "-", "8"],
  :options=>[9]},
 {:coords=>[7, 7],
  :row=>["4", "3", "-", "-", "2", "-", "5", "-", "1"],
  :col=>["-", "-", "1", "-", "9", "5", "3", "-", "-"],
  :box=>["-", "3", "-", "5", "-", "1", "9", "-", "-"],
  :options=>[6, 7, 8]},
 {:coords=>[8, 1],
  :row=>["6", "-", "-", "3", "-", "8", "9", "-", "-"],
  :col=>["-", "9", "-", "1", "6", "-", "-", "3", "-"],
  :box=>["-", "-", "7", "4", "3", "-", "6", "-", "-"],
  :options=>[2, 5]},
 {:coords=>[8, 2],
  :row=>["6", "-", "-", "3", "-", "8", "9", "-", "-"],
  :col=>["5", "-", "-", "9", "2", "-", "7", "-", "-"],
  :box=>["-", "-", "7", "4", "3", "-", "6", "-", "-"],
  :options=>[1]},
 {:coords=>[8, 4],
  :row=>["6", "-", "-", "3", "-", "8", "9", "-", "-"],
  :col=>["-", "7", "-", "-", "8", "6", "-", "2", "-"],
  :box=>["6", "-", "-", "-", "2", "-", "3", "-", "8"],
  :options=>[1, 4, 5]},
 {:coords=>[8, 7],
  :row=>["6", "-", "-", "3", "-", "8", "9", "-", "-"],
  :col=>["-", "-", "1", "-", "9", "5", "3", "-", "-"],
  :box=>["-", "3", "-", "5", "-", "1", "9", "-", "-"],
  :options=>[2, 4, 7]},
 {:coords=>[8, 8],
  :row=>["6", "-", "-", "3", "-", "8", "9", "-", "-"],
  :col=>["-", "5", "9", "6", "-", "-", "-", "1", "-"],
  :box=>["-", "3", "-", "5", "-", "1", "9", "-", "-"],
  :options=>[2, 4, 7]}
]
  end

  let(:puzzle_string) do
    '1-58-2----9--764-52--4--819-19--73-6762-83-9-----61-5---76---3-43--2-5-16--3-89--'
  end

  describe '#play' do
    let(:args) do
      {
        puzzles: ['1-58-2----9--764-52--4--819-19--73-6762-83-9-----61-5---76---3-43--2-5-16--3-89--']
      }
    end
    let(:sudoku_score_keys) do
      %i[round rounds solved starting_board final_board duration starting_dash_count ending_dash_count]
    end

    it 'play' do
      expect(solver_obj.play(args).first.keys).to eql(sudoku_score_keys)
    end
  end

  describe '#remove_quotes' do
    it 'remove_quotes' do
      expect(solver_obj.remove_quotes(rows)).to eql(rows)
    end
  end

  describe '#number_or_nil' do
    let(:string_in) { '1' }
    let(:string_out) { 1 }

    it 'number_or_nil' do
      expect(solver_obj.number_or_nil(string_in)).to eql(string_out)
    end
  end

  describe '#format_puzzle_string' do
    it 'format_puzzle_string' do
      expect(solver_obj.format_puzzle_string(puzzle_string)).to eql(formatted_rows)
    end
  end

  describe '#start_puzzle' do
    let(:res) { true }

    it 'start_puzzle' do
      expect(solver_obj.start_puzzle(puzzle_string)).to eql(res)
    end
  end

  describe '#get_dash_count_totals' do
    let(:total_dash_count) { 41 }

    it 'get_dash_count_totals' do
      expect(solver_obj.get_dash_count_totals(rows)).to eql(total_dash_count)
    end
  end

  describe '#looper' do
    let(:res) { true }

    it 'looper' do
      expect(solver_obj.looper(puzzle_string, updated_rows)).to eql(res)
    end
  end

  describe '#find_column' do
    let(:output) do
      [
        ['1', '-', '2', '-', '7', '-', '-', '4', '6'],
        ['-', '9', '-', '1', '6', '-', '-', '3', '-'],
        ['5', '-', '-', '9', '2', '-', '7', '-', '-'],
        ['8', '-', '4', '-', '-', '-', '6', '-', '3'],
        ['-', '7', '-', '-', '8', '6', '-', '2', '-'],
        ['2', '6', '-', '7', '3', '1', '-', '-', '8'],
        ['-', '4', '8', '3', '-', '-', '-', '5', '9'],
        ['-', '-', '1', '-', '9', '5', '3', '-', '-'],
        ['-', '5', '9', '6', '-', '-', '-', '1', '-']
      ]
    end

    it 'find_column' do
      expect(solver_obj.find_column(rows)).to eql(output)
    end
  end

  describe '#find_dash_coords' do
    let(:coords) do
      [
        [0, 1],
        [0, 4],
        [0, 6],
        [0, 7],
        [0, 8],
        [1, 0],
        [1, 2],
        [1, 3],
        [1, 7],
        [2, 1],
        [2, 2],
        [2, 4],
        [2, 5],
        [3, 0],
        [3, 3],
        [3, 4],
        [3, 7],
        [4, 3],
        [4, 6],
        [4, 8],
        [5, 0],
        [5, 1],
        [5, 2],
        [5, 3],
        [5, 6],
        [5, 8],
        [6, 0],
        [6, 1],
        [6, 4],
        [6, 5],
        [6, 6],
        [6, 8],
        [7, 2],
        [7, 3],
        [7, 5],
        [7, 7],
        [8, 1],
        [8, 2],
        [8, 4],
        [8, 7],
        [8, 8]
      ]
    end

    it 'find_dash_coords' do
      expect(solver_obj.find_dash_coords(rows)).to eql(coords)
    end
  end

  describe '#find_box' do
    let(:boxes) do
      [
        ["1", "-", "5", "-", "9", "-", "2", "-", "-"],
         ["8", "-", "2", "-", "7", "6", "4", "-", "-"],
         ["-", "-", "-", "4", "-", "5", "8", "1", "9"],
         ["-", "1", "9", "7", "6", "2", "-", "-", "-"],
         ["-", "-", "7", "-", "8", "3", "-", "6", "1"],
         ["3", "-", "6", "-", "9", "-", "-", "5", "-"],
         ["-", "-", "7", "4", "3", "-", "6", "-", "-"],
         ["6", "-", "-", "-", "2", "-", "3", "-", "8"],
         ["-", "3", "-", "5", "-", "1", "9", "-", "-"]
        ]
    end

    it 'find_box' do
      expect(solver_obj.find_box(rows)).to eql(boxes)
    end
  end

  describe '#make_data_hash' do
    it 'make_data_hash' do
      expect(solver_obj.make_data_hash(rows)).to eql(data_hashes)
    end
  end

  describe '#find_dash_options' do
    it 'find_dash_options' do
      expect(solver_obj.find_dash_options(data_hashes)).to eql(option_hashes)
    end
  end

  describe '#get_lowest_option_count_hash' do
    let(:output) do
      {
        :coords=>[1, 3],
       :row=>["-", "9", "-", "-", "7", "6", "4", "-", "5"],
       :col=>["8", "-", "4", "-", "-", "-", "6", "-", "3"],
       :box=>["8", "-", "2", "-", "7", "6", "4", "-", "-"],
       :options=>[1]
      }
    end

    it 'get_lowest_option_count_hash' do
      expect(solver_obj.get_lowest_option_count_hash(option_hashes)).to eql(output)
    end
  end

  describe '#fill_dashes' do
    let(:rows_out) do
      [
        ["1", "-", "5", "8", "-", "2", "-", "-", "-"],
       ["-", "9", "-", 1, "7", "6", "4", 2, "5"],
       ["2", 7, "-", "4", "-", 5, "8", "1", "9"],
       ["-", "1", "9", "-", "-", "7", "3", "-", "6"],
       ["7", "6", "2", 5, "8", "3", 1, "9", 4],
       ["-", "-", "-", "-", "6", "1", "-", "5", "-"],
       ["-", "-", "7", "6", "-", "-", 2, "3", "-"],
       ["4", "3", 8, "-", "2", 9, "5", "-", "1"],
       ["6", "-", 1, "3", "-", "8", "9", "-", "-"]
      ]
    end

    it 'fill_dashes' do
      expect(solver_obj.fill_dashes(option_hashes, rows)).to eql(rows_out)
    end
  end

  describe '#solved?' do
    let(:output) { true }

    it 'solved?' do
      expect(solver_obj.solved?(board)).to eql(output)
    end
  end

  describe '#pretty_board' do
    let(:output) do
      [
        "1  4  5  8  9  2  6  7  3\n",
       "8  9  3  1  7  6  4  2  5\n",
       "2  7  6  4  3  5  8  1  9\n",
       "5  1  9  2  4  7  3  8  6\n",
       "7  6  2  5  8  3  1  9  4\n",
       "3  8  4  9  6  1  7  5  2\n",
       "9  5  7  6  1  4  2  3  8\n",
       "4  3  8  7  2  9  5  6  1\n",
       "6  2  1  3  5  8  9  4  7\n"
      ]
    end

    it 'pretty_board' do
      expect(solver_obj.pretty_board(board)).to eql(output)
    end
  end
end
