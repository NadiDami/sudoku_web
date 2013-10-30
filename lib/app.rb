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

def replace_number_with_zero_in array
  array[rand(array.length)] = "0"
  array
end

def count_zeros_in array
  array.select {|s| s == "0"}.count
end

def place_zeros_in array, number_of_zeros
  until (count_zeros_in array) == number_of_zeros
    array = replace_number_with_zero_in array
  end
  array
end

def puzzle sudoku
  puzzle_board = sudoku.dup
  place_zeros_in puzzle_board, 40
end

def generate_new_puzzle_if_necessary
  return if session[:current_solution]
  sudoku = random_sudoku
  session[:solution] = sudoku
  session[:puzzle] = puzzle(sudoku)
  session[:current_solution] = session[:puzzle]    
end

def prepare_to_check_solution
  @check_solution = session[:check_solution]
  session[:check_solution] = nil
end

get '/' do
  prepare_to_check_solution
  generate_new_puzzle_if_necessary
  @current_solution = session[:current_solution]
  @puzzle = @current_solution
  @solution = session[:solution]
  erb :index
end

get '/solution' do
  @current_solution = session[:solution]
  @puzzle = @current_solution
  @solution = session[:solution]
  erb :index  
end

post '/' do
  boxes = params["cell"].each_slice(9).to_a
  cells = (0..8).to_a.inject([]) do |memo, index|
    memo += boxes[index/3*3, 3].map do |box| 
      box[index%3*3, 3]
    end.flatten
  end
  session[:current_solution] = cells.map{|value| value.to_i }.join
  session[:check_solution] = true
  redirect to("/")
end


helpers do
  def cell_value(value)
    return '' if value.to_i == 0
    value
  end
end





