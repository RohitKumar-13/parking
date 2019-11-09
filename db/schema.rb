# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_11_09_105107) do

  create_table "hdb_car_parkings", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "car_park_no", null: false
    t.string "address", null: false
    t.float "x_coord", null: false
    t.float "y_coord", null: false
    t.string "car_park_type", null: false
    t.string "type_of_parking_system", null: false
    t.string "short_term_parking"
    t.string "free_parking"
    t.boolean "night_parking", default: false
    t.integer "car_park_decks", default: 0
    t.float "gantry_height", default: 0.0
    t.boolean "car_park_basement", default: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["car_park_type"], name: "index_hdb_car_parkings_on_car_park_type"
    t.index ["type_of_parking_system"], name: "index_hdb_car_parkings_on_type_of_parking_system"
    t.index ["x_coord"], name: "index_hdb_car_parkings_on_x_coord"
    t.index ["y_coord"], name: "index_hdb_car_parkings_on_y_coord"
  end

end
