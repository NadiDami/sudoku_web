require './lib/app'

describe 'Web Sudoku Solver' do

  it 'will randomly replace an element with a space in an array of numbers as strings' do
    array = ["1", "1"]
    final_array = [[" ", "1"], ["1", " "]]
    expect(final_array).to include replace_number_with_space_in array
  end

  it 'will return the number of spaces in an array' do
    expect(count_spaces_in ["1", " ", " ", "4", " "]). to eq 3
  end

  it "will randomly replace 6 numbers with a space" do
      array = ["1","2","3","1","2","3","1","2","3","1","2","3"]
      number_of_spaces = 6
      array_with_spaces = place_spaces_in array, number_of_spaces
      expect(count_spaces_in array_with_spaces).to eq 6
  end




end