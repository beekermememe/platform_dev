require 'rails_helper'

RSpec.describe WordsController, type: :controller do

  describe "POST /words.json" do
    it "returns http success" do
      post :create, format: :json, words: ["banana","shoes"]
      expect(response).to have_http_status(:success)
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
    it "returns a status 204 on success" do
      delete :delete_word, format: :json, word: "idea"
      expect(response.status).to eq(204)
    end

    it "should call the method to delete a single word" do
      expect(Word).to receive("delete_word").with("idea")
      delete :delete_word, format: :json, word: "idea"
    end
  end

end
