class WordsController < ApplicationController

  def delete

  end

  def delete_word

  end

  def create
    words_to_add = params[:words]
    Word.add_new_words(words_to_add)
    render json: {}
  end



end
