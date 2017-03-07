class WordsController < ApplicationController

  def delete_all_words
    Word.clear_all_words
    render json: nil, status: 204
  end

  def delete_word
    word_to_delete = params[:word]
    if(word_to_delete)
      Word.delete_word(word_to_delete)
    end

    render json: nil, status: 200
  end

  def create
    words_to_add = params[:words]
    Word.add_new_words(words_to_add)
    render json: nil, status: 201
  end


end
