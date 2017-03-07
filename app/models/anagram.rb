class Anagram
  class << self
    def find(word,limit = nil)
      source_letter_frequency_count = get_letter_frequency(word)
      anagrams = []
      Word.all.each do |potential_target|
        break if limit && anagrams.length == limit
        next if potential_target.source_word.downcase == word.downcase
        next if potential_target.source_word.length != word.length
        if( check_match(source_letter_frequency_count,potential_target.source_word) == true)
          anagrams << potential_target.source_word
        end
      end
      return anagrams
    end

    def get_letter_frequency(word)
      letter_frequency_count = {}
      word.downcase.chars.each do |letter|
        if letter_frequency_count[letter]
          letter_frequency_count[letter] += 1
        else
          letter_frequency_count[letter] = 1
        end
      end
      return letter_frequency_count
    end


    def check_match(source_letter_frequency_count,target_word)
      target_word_frequency_count = get_letter_frequency(target_word)
      source_letter_frequency_count.each do |letter,frequency_count|
        if target_word_frequency_count[letter].nil? || target_word_frequency_count[letter] != frequency_count
          return false
        end
      end
      return true
    end
  end

end