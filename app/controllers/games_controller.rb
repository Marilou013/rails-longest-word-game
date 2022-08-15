class GamesController < ApplicationController
  require 'open-uri'
  require 'json'

  def new
    @letters = ('A'..'Z').to_a.shuffle[0..9]
  end

  def english_word?(word)
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    return json['found']
  end


  def score
    word = params[:word]
    grid = params[:grid]
    english_word?(word)
    @result = "Congratulations ! #{word} is a valid english word !" if english_word?(word)
    @result = "Sorry but #{word} does not seem to be  valid english word..." unless english_word?(word)
    @result = "Sorry but #{word} can't be built out of #{grid}" unless grid_word?(word, grid)
    @result = 'BRAVO' if english_word?(word) && grid_word?(word, grid)
  end

  def grid_word?(word, grid)
    word.chars.all? { |letter| grid.include?(letter.upcase) }
  end
end
