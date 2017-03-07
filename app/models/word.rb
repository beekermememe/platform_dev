class Word < ActiveRecord::Base
  def self.reload_word_data(word_data_file_name=nil)
    clear_old_words
    word_data_file_name ||= "#{Rails.root.join('source_data','dictionary.txt')}"
    begin
      words_to_create = []
      File.open(word_data_file_name,"r") do |f|
        f.each_line do |line|
          words_to_create << {source_word: line.chomp()}
        end
      end
      puts "word_to_create" + words_to_create.join(",")
      Word.create(words_to_create)
      if(words_to_create.length != Word.count)
        return false
      else
        return true
      end
    rescue Exception => e
      puts "#{e.message}"
    end
    return false
  end

  def self.clear_old_words
    Word.delete_all
  end
end
