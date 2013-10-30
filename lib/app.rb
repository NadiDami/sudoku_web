require 'sinatra'
require './lib/sudoku'
require './lib/cell'

enable :sessions

set :views, File.join(File.dirname(__FILE__), '..', 'views')

def random_sudoku
  seed = (1..9).to_a.shuffle + Array.new(81-9, 0)
  sudoku = Sudoku.new(seed.join)
  sudoku.solve!
  sudoku.to_s.chars
end

def replace_number_with_space_in array
  array[rand(array.length)] = " "
  array
end

def count_spaces_in array
  array.select {|s| s == " "}.count
end

def place_spaces_in array, number_of_spaces
  until (count_spaces_in array) == number_of_spaces
    array = replace_number_with_space_in array
  end
  array
end

def puzzle sudoku
  place_spaces_in sudoku, 40
end

get '/' do
  sudoku = random_sudoku
  session[:solution] = sudoku
  @current_solution = puzzle(sudoku)
  erb :index
end