require 'rails_helper'

RSpec.describe WordsController, type: :controller do

  describe "POST /words.json" do
    it "returns http status code 201" do
      post :create, format: :json, words: ["banana","shoes"]
      expect(response.status).to eq(201)
    end

    it "call the method to add the words passed to the existing list of words" do
      expect(Word).to receive(:add_new_words).with(["banana","shoes"]).and_return(nil)
      post :create, format: :json, words: ["banana","shoes"]
    end

  end

  describe "DELETE /words.json" do
    it "returns a status 204 on success" do
      delete :delete_all_words, format: :json
      expect(response.status).to eq(204)
    end

    it "should call the method to delete all the words" do
      expect(Word).to receive("clear_all_words")
      delete :delete_all_words, format: :json
    end

  end

  describe "DELETE /words/word_to_delete.json" do
    it "returns a status 200 on success" do
      delete :delete_word, format: :json, word: "idea"
      expect(response.status).to eq(200)
    end

    it "should call the method to delete a single word" do
      expect(Word).to receive("delete_word").with("idea")
      delete :delete_word, format: :json, word: "idea"
    end
  end

  describe "GET /words/stats.json" do
    it "returns a json list of the stats" do
      expect(Word).to receive("count").and_return(1)
      expect(WordStat).to receive("get_average").and_return(2)
      expect(WordStat).to receive("get_minimum").and_return(3)
      expect(WordStat).to receive("get_maximum").and_return(4)
      expect(WordStat).to receive("get_median").and_return(5)
      get :stats, format: :json
      expected_response = {
          stats: {
            word_count: 1,
            max_word_length: 4,
            min_word_length: 3,
            average_word_length: 2,
            median_word_length: 5
          }
      }.to_json
      expect(response.body).to eq(expected_response)
    end
  end

end
