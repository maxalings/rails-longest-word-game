class GamesController < ApplicationController
  def new
    @letters = ('a'..'z').to_a
  end

  def score
    @word = params[:word]  # Retrieve the word entered by the user
    @grid = params[:grid]  # Retrieve the grid (if you are passing it)

    # Check if the word can be made out of the grid (logic to implement here)
    if word_in_grid?(@word, @grid)
      # Check if the word is valid English using the dictionary API
      response = HTTParty.get("https://dictionary.lewagon.com/#{@word}")

      if response.success?
        # If it's a valid word
        @score = "Valid word, score: #{calculate_score(@word)}"
      else
        # If it's not a valid word
        @score = "Not a valid English word!"
      end
    else
      # If the word can't be formed from the grid
      @score = "Word can't be formed from the grid!"
    end
  end

  private

  def word_in_grid?(word, grid)
    # Logic to check if the word can be made from the grid
    # Example logic:
    grid_letters = grid.chars
    word.chars.all? { |letter| grid_letters.include?(letter) && grid_letters.delete_at(grid_letters.index(letter)) }
  end

  def calculate_score(word)
    # Implement your scoring logic here
    word.length
  end
end
