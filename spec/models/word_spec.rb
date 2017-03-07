require 'rails_helper'

RSpec.describe Word, type: :model do
  describe "self.reload_word_data" do
    it "should read in all the words from a file and indicate sucess" do
      expect(Word.count).to eq(0)
      work_status = Word.reload_word_data(Rails.root.join("spec","spec_data","test_data.txt"))
      expect(work_status).to eq(true)
      expect(Word.count).to eq(10)
    end

    it "should read fail graciously if it cannot find the file to read the words from" do
      expect(Word.count).to eq(0)
      work_status = Word.reload_word_data("nofilehere")
      expect(work_status).to eq(false)
    end
  end

  describe "self.clear_all_words" do
    it "should delete all the words" do
      Word.create([{source_word: "MAT"},{source_word: "ATM"}])
      expect(Word.count).to eq(2)
      Word.clear_all_words
      expect(Word.count).to eq(0)
    end
  end

  describe "self.add_new_words" do
    it "should add new words to the existing list" do
      words_to_add = ["MAT","ATM"]
      expect(Word.count).to eq(0)
      Word.add_new_words(words_to_add)
      expect(Word.count).to eq(2)
    end

    it "should detect any duplicate words and not add them to the existing list" do
      Word.create({source_word: "MAT"})
      expect(Word.count).to eq(1)
      words_to_add = ["MAT","ATM"]
      Word.add_new_words(words_to_add)
      expect(Word.count).to eq(2)
    end
  end

  describe "self.create_new_word_objects_from_array" do
    it "should return an array of new word objects in the form of a hash" do
      word_array = ["MAT","ATM"]
      object_to_inspect = Word.create_new_word_objects_from_array(word_array)
      expect(object_to_inspect).to eq([{source_word: "MAT"},{source_word: "ATM"}])
    end
  end

  describe "self.delete_word" do
    it "should add new words to the existing list" do
      Word.create([{source_word: "MAT"},{source_word: "ATM"}])
      expect(Word.count).to eq(2)
      Word.delete_word("MAT")
      expect(Word.count).to eq(1)
      expect(Word.first.source_word).to eq("ATM")
    end
  end

  describe "self.get_anagrams" do
    it "should return anagrams for the word dog" do
      expect(1).to eq(0)
    end
  end

end
