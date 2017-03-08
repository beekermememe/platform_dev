class AnagramsController < ApplicationController
  def get
    word_to_use = params[:word]
    limit = params[:limit] ? params[:limit].to_i : nil
    include_proper_nouns = params[:include_proper_nouns].nil? ? nil : params[:include_proper_nouns].to_s.downcase == "true"
    if word_to_use
      anagrams = Anagram.find(word_to_use,limit,include_proper_nouns)
      render json: {anagrams: anagrams}
     else
      render json: {anagrams:[]}
    end
  end
end
