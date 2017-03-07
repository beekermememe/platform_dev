require 'rails_helper'

RSpec.describe Word, type: :model do
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
