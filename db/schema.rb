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

ActiveRecord::Schema[7.0].define(version: 2022_06_12_224341) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bookings", force: :cascade do |t|
    t.string "user"
    t.text "seats"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "flight"
  end

  create_table "flights", force: :cascade do |t|
    t.date "date"
    t.time "time"
    t.string "origin"
    t.string "destiny"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "ocupation"
  end

  create_table "seats", force: :cascade do |t|
    t.bigint "flight_id"
    t.integer "row"
    t.string "column"
    t.boolean "disponibility"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["flight_id"], name: "index_seats_on_flight_id"
  end

  add_foreign_key "seats", "flights"
end
