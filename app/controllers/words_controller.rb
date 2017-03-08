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

  def stats
    word_count = Word.count
    max_size = WordStat.get_maximum
    min_size = WordStat.get_minimum
    average_size = WordStat.get_average
    median = WordStat.get_median
    render json: {
      stats: {
          word_count: word_count,
          max_word_length: max_size,
          min_word_length: min_size,
          average_word_length: average_size,
          median_word_length: median
      }
    }
  end

end
