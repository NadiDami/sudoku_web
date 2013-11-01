require 'sinatra'
require 'sinatra/partial'
require 'rack-flash'
require './lib/sudoku'
require './lib/cell'
require './helpers/application'


register Sinatra::Partial
set :partial_template_engine, :erb

use Rack::Flash


enable :sessions

set :views, File.join(File.dirname(__FILE__), '..', 'views')

set :public_folder, File.join(File.dirname(__FILE__), '..', 'public')

set :session_secret, "Secret cookie key"


def random_sudoku
  seed = (1..9).to_a.shuffle + Array.new(81-9, 0)
  sudoku = Sudoku.new(seed.join)
  sudoku.solve!
  sudoku.to_s.chars
end

def replace_number_with_zero_in array
  array[rand(array.length)] = 0
  array
end

def count_zeros_in array
  array.select {|s| s == 0}.count
end

def place_zeros_in array, number_of_zeros
  until (count_zeros_in array) == number_of_zeros
    array = replace_number_with_zero_in array
  end
  array
end

def easy_puzzle sudoku
  puzzle_board = sudoku.dup
  place_zeros_in puzzle_board, 35
end

def hard_puzzle sudoku
  puzzle_board = sudoku.dup
  place_zeros_in puzzle_board, 55
end

def generate_new_easy_puzzle_if_necessary
  return if session[:current_solution]
  sudoku = random_sudoku
  session[:solution] = sudoku
  session[:puzzle] = easy_puzzle(sudoku)
  session[:current_solution] = session[:puzzle]    
end

def generate_new_hard_puzzle_if_necessary
  return if session[:current_solution]
  sudoku = random_sudoku
  session[:solution] = sudoku
  session[:puzzle] = hard_puzzle(sudoku)
  session[:current_solution] = session[:puzzle]    
end

def prepare_to_check_solution
  @check_solution = session[:check_solution]
  if @check_solution
    flash[:notice] = "Incorrect values are highlighted"
  end
  session[:check_solution] = nil
end

def box_order_to_row_order(cells)

  boxes = cells.each_slice(9).to_a

  (0..8).to_a.inject([]) {|memo, i|
   
    first_box_index = i / 3 * 3
    three_boxes = boxes[first_box_index, 3]
    three_rows_of_three = three_boxes.map do |box| 
      row_number_in_a_box = i % 3
      first_cell_in_the_row_index = row_number_in_a_box * 3
      box[first_cell_in_the_row_index, 3]
    end
   memo += three_rows_of_three.flatten
  }
end

get '/' do
  prepare_to_check_solution
  generate_new_easy_puzzle_if_necessary
  @current_solution = session[:current_solution]
  @puzzle = session[:puzzle]
  @solution = session[:solution]
  erb :index
end

get '/solution' do
  redirect to ("/") if session[:solution] == nil
  @current_solution = session[:solution]
  @puzzle = @current_solution
  @solution = session[:solution]
  erb :index  
end

post '/' do
  cells = box_order_to_row_order(params["cell"])
  session[:current_solution] = cells.map{|value| value.to_i }.join
  session[:check_solution] = true
  redirect to("/")
end

get '/neweasygame' do
  sudoku = random_sudoku
  session[:solution] = sudoku
  session[:puzzle] = easy_puzzle(sudoku)
  session[:current_solution] = session[:puzzle]
  redirect to("/")
  erb :index
end

get '/newhardgame' do
  sudoku = random_sudoku
  session[:solution] = sudoku
  session[:puzzle] = hard_puzzle(sudoku)
  session[:current_solution] = session[:puzzle]
  redirect to("/")
  erb :index
end

get '/restart' do
  session[:current_solution] = session[:puzzle]
  redirect to("/")
end









