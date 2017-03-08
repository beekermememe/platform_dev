namespace :migrate do
  desc "Refresh the is proper noun flag on Word object"
  task :refresh_is_proper_noun_flag => :environment do
    Word.all.each do |word|
     # word is capitalized - a proper noun if lowercasing the first char changes it
      word.is_proper_noun = (word.source_word[0] != word.source_word[0].downcase)
      word.save
    end
  end
end