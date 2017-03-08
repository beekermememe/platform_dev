class AnagramsController < ApplicationController

  api :GET, '/anagrams/:word', "Returns a JSON array of English-language words that are anagrams of the word passed in the URL"
  param :word, String, :desc => "Word that you wish to find anagrams for", :required => true
  param :limit, :number, :desc => "The maximum number of results you want to return. Default is 20"
  param :include_proper_nouns, [true,false], :desc => "Do you wish to return proper nouns in the result set. Default is true"
  formats ['json']
  example " {'words': ['meats','steam'] } "
  def get
    word_to_use = params[:word]
    limit = params[:limit] ? params[:limit].to_i : 20
    include_proper_nouns = params[:include_proper_nouns].nil? ? nil : params[:include_proper_nouns].to_s.downcase == "true"
    if word_to_use
      anagrams = Anagram.find(word_to_use,limit,include_proper_nouns)
      render json: {anagrams: anagrams}
     else
      render json: {anagrams:[]}
    end
  end

  api :GET, '/anagrams/get_max_occurring_anagrams', "Endpoint that identifies words with the most anagrams"
  example '{"anagrams":["angor","argon","goran","grano","groan","nagor","Orang","orang","organ","rogan","Ronga"]}'
  def get_max_occurring_anagrams
    render json: {anagrams: Anagram.get_largest_groupings}
  end
end
