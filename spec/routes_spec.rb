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
end