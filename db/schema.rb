# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2026_11_27_021321) do
  create_table "click_events", force: :cascade do |t|
    t.integer "link_id", null: false
    t.string "user_agent"
    t.string "referer"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["link_id"], name: "index_click_events_on_link_id"
  end

  create_table "links", force: :cascade do |t|
    t.string "original_url"
    t.string "short_code"
    t.integer "clicks_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["short_code"], name: "index_links_on_short_code", unique: true
  end

  add_foreign_key "click_events", "links"
end
