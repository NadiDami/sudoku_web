helpers do

   def colour_class(solution_to_check, puzzle_value, current_solution_value, solution_value)
    must_be_guessed = puzzle_value.to_i == 0 
    tried_to_guess = current_solution_value.to_i != 0 
    guessed_incorrectly = current_solution_value != solution_value
    puts puzzle_value.to_i
    puts tried_to_guess
    puts solution_value
    puts current_solution_value
    puts "*****************"
    puts solution_to_check
    puts must_be_guessed
    
    puts guessed_incorrectly
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


end