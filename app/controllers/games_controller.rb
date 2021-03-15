require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = 10.times.map { ('A'..'Z').to_a.sample }
  end

  def score
    run_game(params[:answer], params[:letters])
  end

  private

  def in_english?(attempt)
    json_hash = JSON.parse(open("https://wagon-dictionary.herokuapp.com/#{attempt}").read)
    json_hash['found']
  end

  def in_grid?(attempt, grid)
    letters = attempt.upcase.split('')
    letters.all? { |element| letters.count(element) <= grid.count(element) }
  end
  def run_game(attempt, grid)
    if in_english?(attempt) && in_grid?(attempt, grid)
      @score = (attempt.size * 10)
      @answer = 'well done'
    elsif in_english?(attempt) == false
      @answer = 'your word is not an english word'
    else
      @answer = 'your word is not in the grid'
    end
  end
end
