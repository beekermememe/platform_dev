class AddIsProperNounIndexToWords < ActiveRecord::Migration
  def change
    add_index :words, :is_proper_noun
  end
end
