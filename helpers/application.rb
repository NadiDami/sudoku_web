helpers do

  def colour_class(solution_to_check, puzzle_value, current_solution_value, solution_value)
    must_be_guessed = puzzle_value.to_i == 0 
    tried_to_guess = current_solution_value.to_i != 0 
    guessed_incorrectly = current_solution_value != solution_value

      if solution_to_check && must_be_guessed && tried_to_guess && guessed_incorrectly
        'incorrect'
      elsif !must_be_guessed
        'value-provided'
      end
  end

  def cell_value(value)
    return '' if value.to_i == 0
    value
  end

  def cell_disabled?(cell_index)
    cell_index != 0
  end

end