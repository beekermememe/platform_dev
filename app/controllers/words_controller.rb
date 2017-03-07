class WordsController < ApplicationController

  def delete

  end

  def delete_word

  end

  def create
    words_to_add = params[:words]
    Word.
    render json: {}
  end


end
