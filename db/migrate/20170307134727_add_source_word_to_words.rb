class AddSourceWordToWords < ActiveRecord::Migration
  def change
    add_column :words, :source_word, :string
  end
end
