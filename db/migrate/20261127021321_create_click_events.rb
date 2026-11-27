class CreateClickEvents < ActiveRecord::Migration[8.1]
  def change
    create_table :click_events do |t|
      t.references :link, null: false, foreign_key: true
      t.string :user_agent
      t.string :referer

      t.timestamps
    end
  end
end
