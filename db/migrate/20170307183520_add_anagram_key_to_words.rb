class AddAnagramKeyToWords < ActiveRecord::Migration
  def change
    add_column :words, :anagram_key, :string
  end
end
