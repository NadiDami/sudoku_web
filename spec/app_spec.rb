require './lib/app'

describe 'Web Sudoku Solver' do

  it 'will randomly replace an element with a zero in an array of numbers as strings' do
    array = [1, 1]
    final_array = [[0, 1], [1, 0]]
    expect(final_array).to include replace_number_with_zero_in array
  end

  it 'will return the number of spaces in an array' do
    expect(count_zeros_in [1, 0, 0, 4, 0]).to eq 3
  end

  it "will randomly replace 6 numbers with a space" do
      array = [1,2,3,1,2,3,1,2,3]
      number_of_zeros = 6
      array_with_zeros = place_zeros_in array, number_of_zeros
      expect(count_zeros_in array_with_zeros).to eq 6
  end

end