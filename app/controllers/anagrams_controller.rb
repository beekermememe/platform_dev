class AnagramsController < ApplicationController
  def get
    word_to_use = params[:word]
    # if word_to_use
      anagrams = Word.get_anagrams(word_to_use)
      render json: {anagrams: anagrams}
    # else
    #   render json: []
    # end
  end
end
