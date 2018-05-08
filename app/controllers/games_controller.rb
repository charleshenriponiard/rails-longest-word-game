require 'open-uri'
 # require 'pry-byebug'



class GamesController < ApplicationController
  def new
    @letters = Array.new(9) {('A'..'Z').to_a.sample}
  end

  def score
    @letters = params[:letters].chars
    @word = params[:answer_user]
    response = open("https://wagon-dictionary.herokuapp.com/#{@word}")
    json = JSON.parse(response.read, symbolize_names: true)
    @score = json

    if @score[:found] == true && @score[:length] <= 10
      @message = "CONGRATULATION, #{@score[:word]} is a valid english word !"
    elsif @score[:found] == false
      @message = "sorry but #{@score[:word]} does not seem to be a valid English word"
    elsif include_letter?
      @message = "Sorry but #{@score[:word]} can't be built of #{@score[:letters]}"
    end
  end
end


private

def include_letter?
  @letters.each do |letter|
    if @word.include?(letter)
      true
    end
  end
end
