class CreateWordStats < ActiveRecord::Migration
  def change
    create_table :word_stats do |t|
      t.integer :word_length
      t.integer :occurance_count

      t.timestamps null: false
    end
  end
end
