class AddIndexToWords < ActiveRecord::Migration
  def change
    add_index :words, :anagram_key
  end
end
