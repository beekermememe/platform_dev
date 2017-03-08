require 'rails_helper'

RSpec.describe WordStat, type: :model do
  before :each do
    Word.create!([
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

  describe  "self.refresh_all" do
    it "should create stats based on the words in the Word table" do
      expect(WordStat.count).to eq(0)
      WordStat.refresh_all
      expect(WordStat.count).to eq(3)
    end

    it "should compress the stats for word lengths" do
      expect(WordStat.count).to eq(0)
      WordStat.refresh_all
      stats = WordStat.where({word_length: 5})
      expect(stats.count).to eq(1)
      expect(stats.first.occurance_count).to eq(3)
    end

  end

  describe  "self.refresh_one" do
    it "should create a new record if one does not exist" do
      expect(WordStat.count).to eq(0)
      WordStat.refresh_one(4)
      expect(WordStat.count).to eq(1)
      expect(WordStat.first.word_length).to eq(4)
      expect(WordStat.first.occurance_count).to eq(4)
    end

    it "should create update and existing record if one exists" do
      WordStat.create({word_length: 4, occurance_count: 1})
      expect(WordStat.count).to eq(1)
      expect(WordStat.first.occurance_count).to eq(1)
      WordStat.refresh_one(4)
      expect(WordStat.count).to eq(1)
      expect(WordStat.first.occurance_count).to eq(4)
    end

  end

  describe  "clear_all" do

  end

  describe  "self.get_average" do
    it "should get the average word length" do
      WordStat.refresh_all
      average = WordStat.get_average
      expect(average).to eq(4.75)
    end
  end

  describe  "self.get_minumum" do
    it "should get the min word length" do
      WordStat.refresh_all
      average = WordStat.get_minimum
      expect(average).to eq(4)
    end
  end

  describe  "self.get_maximum" do
    it "should get the max word length" do
      WordStat.refresh_all
      average = WordStat.get_maximum
      expect(average).to eq(7)
    end
  end

  describe  "self.get_median" do
    it "should calculate the median with an odd number of elements" do
      WordStat.refresh_all
      average = WordStat.get_median
      expect(average).to eq(5)
    end
    it "should calculate the median with an even number of elements" do
      WordStat.refresh_all
      WordStat.create({word_length: 2, occurance_count: 4})
      average = WordStat.get_median
      expect(average).to eq(4.5)
    end
  end

end
