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

ActiveRecord::Schema.define(version: 2021_05_07_035947) do

  create_table "posts", id: :integer, charset: "utf8mb4", force: :cascade do |t|
    t.string "title", null: false
    t.text "description", null: false
    t.integer "status", null: false
    t.integer "create_user_id", null: false
    t.integer "updated_user_id", null: false
    t.integer "deleted_user_id"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", id: :integer, charset: "utf8mb4", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.text "password_digest", null: false
    t.string "profile", null: false
    t.string "role", limit: 1
    t.string "phone"
    t.string "address"
    t.date "dob"
    t.integer "create_user_id", null: false
    t.integer "updated_user_id", null: false
    t.integer "deleted_user_id"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["create_user_id"], name: "fk_rails_bc60bf1428"
    t.index ["updated_user_id"], name: "fk_rails_562ffc0a48"
  end

  add_foreign_key "users", "users", column: "create_user_id"
  add_foreign_key "users", "users", column: "updated_user_id"
end
