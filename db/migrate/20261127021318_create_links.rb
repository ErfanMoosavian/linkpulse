class CreateLinks < ActiveRecord::Migration[8.1]
  def change
    create_table :links do |t|
      t.string :original_url
      t.string :short_code
      t.integer :clicks_count

      t.timestamps
    end
    add_index :links, :short_code, unique: true
  end
end
