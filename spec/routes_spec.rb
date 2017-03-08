require 'rails_helper'

RSpec.describe "words routes", :type => :routing do
  it "routes DELETE /words to words#delete" do
    expect(:delete => "/words.json").to route_to(:controller => "words", :action =>  "delete_all_words", :format => "json")
  end

  it "routes DELETE /words/word_to_delete.json to words#delete_word" do
    expect(:delete => "/words/word_to_delete.json").to route_to(
        :controller => "words",
        :action =>  "delete_word",
        :word => "word_to_delete",
        :format => "json")
  end

  it "routes POST  to words#post" do
    expect(:post => "/words", format: :json).to route_to(
        :controller => "words",
        :action =>  "create")
  end

  it "routes GET /words/stats  to words#stats" do
    expect(:get => "/words/stats", format: :json).to route_to(
        :controller => "words",
        :action =>  "stats")
  end
end

RSpec.describe "anagrams routes", :type => :routing do
  it "routes get /anagrams/word to anagrams#get" do
    expect(:get => "/anagrams/word_to_search", format: :json).to route_to(
        :controller => "anagrams",
        :action =>  "get",
        :word => "word_to_search")
  end

  it "routes get /anagrams/get_max_occurring_anagrams to anagrams#get_max_occurring_anagrams" do
    expect(:get => "/anagrams/get_max_occurring_anagrams", format: :json).to route_to(
        :controller => "anagrams",
        :action =>  "get_max_occurring_anagrams")
  end
end