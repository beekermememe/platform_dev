class WordStat < ActiveRecord::Base
  class << self
    def get_minimum
      Word.order("LENGTH(source_word) ASC").first.source_word.length
    end

    def get_maximum
      Word.order("LENGTH(source_word) DESC").first.source_word.length
    end

    def refresh_all
      max_word_length = Word.order("LENGTH(source_word) DESC").first.source_word.length
      min_word_length = Word.order("LENGTH(source_word) ASC").first.source_word.length
      buckets = []
      min_word_length.upto(max_word_length).each do |word_length|
        occurance_count = Word.where("LENGTH(source_word) = ?",word_length).count
        buckets << {occurance_count: occurance_count,word_length: word_length} if occurance_count > 0
      end
      WordStat.create(buckets)
    end

    def clear_all
      WordStat.delete_all
    end

    def refresh_one(word_size)
      occurance_count = Word.where("LENGTH(source_word) = ?",word_size).count
      existing = WordStat.find_by({word_length: word_size})
      if existing
        existing.occurance_count = occurance_count
        existing.save
      else
        WordStat.create( {occurance_count: occurance_count,word_length: word_size})
      end
    end

    def get_median
      ordered_word_stats = WordStat.order("occurance_count asc")
      count = ordered_word_stats.length
      if count.odd?
        return ordered_word_stats[count/2].word_length
      else
        median = (ordered_word_stats[count/2].word_length + ordered_word_stats[(count/2) - 1].word_length) / 2.0
        return median
      end
    end

    def get_average
      record_count = 0
      sum_of_word_lengths = 0
      WordStat.all.each do |statline|
        record_count += statline.occurance_count
        sum_of_word_lengths += (statline.occurance_count * statline.word_length)
      end
      return record_count.to_f ? sum_of_word_lengths.to_f/record_count.to_f : 0
    end
  end
end
