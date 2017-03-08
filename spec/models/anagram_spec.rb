require 'rails_helper'

RSpec.describe Anagram, type: :model do
  before :each do
    Word.create([
        {source_word: "bear"},
        {source_word: "bare"},
        {source_word: "moar"},
        {source_word: "roam"},
        {source_word: "silence"},
        {source_word: "Steam"},
        {source_word: "meats"},
        {source_word: "mates"}
    ])
  end


  describe "self.get_letter_frequency" do
    it "should extract how often each letter occurs in a word and retun the data in a hash -> {word: occurancy_count" do
      frequency_data = Anagram.get_letter_frequency("ottosttooott")
      expect(frequency_data.count).to equal(3)
      expect(frequency_data["o"]).to equal(5)
      expect(frequency_data["s"]).to equal(1)
      expect(frequency_data["t"]).to equal(6)
    end

    it "should extract treat upper and lower case letters as the same letter" do
      frequency_data = Anagram.get_letter_frequency("OttoSttoooTt")
      expect(frequency_data.count).to equal(3)
      expect(frequency_data["o"]).to equal(5)
      expect(frequency_data["s"]).to equal(1)
      expect(frequency_data["t"]).to equal(6)
    end
  end

  describe "self.check_match" do
    it "should find matching algorithms for the word passed" do
      matches = Anagram.find("rabe")
      expect(matches.length).to eq(2)
      expect(matches).to include("bare")
      expect(matches).to include("bear")
    end

    it "should find matching algorithms for the word passed but never return itself" do
      matches = Anagram.find("bare")
      expect(matches.length).to eq(1)
      expect(matches).to_not include("bare")
      expect(matches).to include("bear")
    end

    it "should find matching algorithms for the word passed independant of case" do
      matches = Anagram.find("RabE")
      expect(matches.length).to eq(2)
      expect(matches).to include("bare")
      expect(matches).to include("bear")
    end

    it "should limit the length returned list if there is a limit passed" do
      matches = Anagram.find("rabe",1)
      expect(matches.length).to eq(1)
    end

    it "should filter out words that are proper nouns" do
      matches1 = Anagram.find("meats",nil,false)
      expect(matches1.length).to eq(1)
      matches2 = Anagram.find("meats",nil,true)
      expect(matches2.length).to eq(2)
    end
  end

  describe "self.get_key" do
    it "should return the anagram key based on word counts" do
      key1 = Anagram.get_key("bare")
      expect(key1).to eq("a1b1e1r1")
    end

    it "should return the anagram key based on word counts independant of case" do
      key1 = Anagram.get_key("BaRe")
      expect(key1).to eq("a1b1e1r1")
    end

    it "should return the same key for word counts in different orders in the word count hash" do
      key1 = Anagram.get_key("bare")
      key2 = Anagram.get_key("aerb")
      expect(key1).to eq(key2)
    end
  end

  describe "self.get_largest_groupings" do
    it "should return a list of all the words with the max number of characters" do
      Word.create({source_word: "arem"})
      Word.create({source_word: "arme"})
      Word.create({source_word: "rame"})
      # now we have 2 goups with 3 anagram - better for our query
      words_returned = Anagram.get_largest_groupings
      expect(words_returned.count).to eq(6)
    end
  end

end