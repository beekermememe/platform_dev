namespace :startup do
  desc "teardown data, reload all words and word stats data"
  task :reload_all_data => :environment do
    Word.clear_all_words
    WordStat.clear_all
    Word.reload_word_data
    WordStat.refresh_all
  end

end