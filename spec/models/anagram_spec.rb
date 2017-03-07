require 'rails_helper'

RSpec.describe Anagram, type: :model do
  before :each do
    Word.create([
        {source_word: "bear"},
        {source_word: "bare"},
        {source_word: "moar"},
        {source_word: "roam"},
        {source_word: "silence"},
        {source_word: "steam"},
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
    it "should return a match if all the letter occurances are the same" do
      source = {"a" => 3,"b" => 4, "d" => 6}
      target = "aaabbbbdddddd"
      expect(Anagram.check_match(source,target)).to eq true
    end

    it "should return a match if all the letter occurances are not the same" do
      source = {"a" => 3,"b" => 4, "d" => 6}
      target = "aaabbbbddddd"
      expect(Anagram.check_match(source,target)).to eq false
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

    it "should linit the length returned list if there is a limit passed" do
      matches = Anagram.find("rabe",1)
      expect(matches.length).to eq(1)
    end
  end

end