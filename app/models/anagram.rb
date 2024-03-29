class Anagram
  class << self

    def find(word,limit = nil, include_proper_nouns = true)
      word_anagram_key = get_key(word)

      anagrams = Word.where({anagram_key: word_anagram_key})
      anagrams = anagrams.where({is_proper_noun: false}) if include_proper_nouns == false
      anagrams = anagrams.where('lower(source_word) != ?',word.downcase)
      anagrams = anagrams.limit(limit) if limit

      anagrams = anagrams.map { |word_object| word_object.source_word}
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

    def get_key(word)
      word_frequency_count = get_letter_frequency(word)
      key = ""
      "a".upto("z").each do |letter|
        if(word_frequency_count[letter])
          key += "#{letter}#{word_frequency_count[letter]}"
        end
      end
      return key
    end

    def get_largest_groupings
      max = 0
      anagram_keys = []
      # This AR query groups by anagram key and then count : returns a hash of key to the size of the group - Handy :)
      Word.group(:anagram_key).count.each do |anagram_key,count|
        if count > max
          max = count
          anagram_keys = []
        end
        anagram_keys << anagram_key if count == max
      end
      return Word.where(anagram_key: anagram_keys).map { |word_object| word_object.source_word}
    end
  end

end