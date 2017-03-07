class Word < ActiveRecord::Base
  before_save :create_anagram_key


  def create_anagram_key
    self.anagram_key = Anagram.get_key(self.source_word)
  end

  class << self

    def get_anagrams(word_to_use)
      return []
    end

    def clear_all_words
      Word.delete_all
    end

    def delete_word(word_to_select)
      word_to_delete = Word.find_by({source_word: word_to_select})
      word_to_delete.delete if word_to_delete
    end

    def add_new_words(words_to_add)
      new_word_objects = create_new_word_objects_from_array(words_to_add)
      new_word_objects.each do |new_word_object|
        Word.find_or_create_by(new_word_object)
      end
    end

    def create_new_word_objects_from_array(word_array)
      word_array.map { |word| {source_word: word}}
    end


    def reload_word_data(word_data_file_name=nil)
      clear_all_words
      word_data_file_name ||= "#{Rails.root.join('source_data','dictionary.txt')}"
      begin
        words_to_create = []
        File.open(word_data_file_name,"r") do |f|
          f.each_line do |line|
            words_to_create << {source_word: line.chomp()}
          end
        end
        Word.create(words_to_create)
        if(words_to_create.length != Word.count)
          return false
        else
          return true
        end
      rescue Exception => e
        Rails.logger.error "#{e.message}"
      end
      return false
    end


  end

end
