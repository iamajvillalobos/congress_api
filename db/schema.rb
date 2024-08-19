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

ActiveRecord::Schema[7.2].define(version: 2024_08_19_103634) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bills", force: :cascade do |t|
    t.integer "congress"
    t.string "number"
    t.string "type"
    t.string "title"
    t.string "origin_chamber"
    t.string "origin_chamber_code"
    t.date "update_date"
    t.datetime "update_date_including_text"
    t.string "url"
    t.json "latest_action"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["congress"], name: "index_bills_on_congress"
    t.index ["type"], name: "index_bills_on_type"
    t.index ["update_date"], name: "index_bills_on_update_date"
    t.index ["url"], name: "index_bills_on_url", unique: true
  end
end
