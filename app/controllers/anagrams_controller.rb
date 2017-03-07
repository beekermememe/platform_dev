class AnagramsController < ApplicationController
  def get
    word_to_use = params[:word]
    limit = params[:limit] ? params[:limit].to_i : nil
    if word_to_use
      anagrams = Anagram.find(word_to_use,limit)
      render json: {anagrams: anagrams}
     else
      render json: {anagrams:[]}
    end
  end
end
