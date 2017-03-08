class AddIsProperNounToWords < ActiveRecord::Migration
  def change
    add_column :words, :is_proper_noun, :boolean
    # lets update the exisiting data so no-one needs to remember
    Rake::Task["migrate:refresh_is_proper_noun_flag"].invoke
  end
end
