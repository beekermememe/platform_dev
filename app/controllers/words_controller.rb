class WordsController < ApplicationController

  api :DELETE, '/words', "This deletes all the words in the anagram lookup table"
  meta :message => "BE CAREFUL WITH THIS ENDPOINT"
  description "This method returns an empty payload and a status code of 204 on success"
  formats ["json"]
  def delete_all_words
    Word.clear_all_words
    render json: nil, status: 204
  end

  api :DELETE, '/words/:word', "This deletes on word from the anagram lookup table"
  param :word, String, "The word in the anagram look up tabe you wish to delete", required: true
  description "This method returns an empty payload and a status code of 200 on success"
  meta :message => "BE CAREFUL WITH THIS ENDPOINT"
  formats ["json"]
  def delete_word
    word_to_delete = params[:word]
    if(word_to_delete)
      Word.delete_word(word_to_delete)
    end
    render json: nil, status: 200
  end

  api :POST, '/words', "This method is passed an array of words in the body and adds them to the anagram lookup table"
  formats ["json"]
  description "This method returns an empty payload and a status code of 201 on success"

  example '{"words":["new word 1","new word 2"]}'
  def create
    words_to_add = params[:words]
    Word.add_new_words(words_to_add)
    render json: nil, status: 201
  end

  api :GET, '/words/stats', "This method returns stats about the current anagram lookup table"
  description "The stats returned are the (1) The number of words in the table (2) The maximum word length (3) The minimum word length (4) The average length of the words in the table (5) The median word length"
  formats ["json"]
  example '{"stats":{"word_count":235886,"max_word_length":24,"min_word_length":1,"average_word_length":9.569126612007494,"median_word_length":10.0}}'
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
