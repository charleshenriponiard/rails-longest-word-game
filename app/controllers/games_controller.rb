require 'open-uri'



class GamesController < ApplicationController
  def new
    @letters = Array.new(9) {('A'..'Z').to_a.sample}
  end

  def score
    @word = params[:answer_user]
    response = open("https://wagon-dictionary.herokuapp.com/#{@word}")
    json = JSON.parse(response.read, symbolize_names: true)
    @score = json

    if @score[:found] == true && @score[:length] <= 10
      @message = "CONGRATULATION, #{@score[:word]} is a valid english word !"
    elsif @score[:found] == false
      @message = "sorry but #{@score[:word]} does not seem to be a valid English word"

    end

  end
end
