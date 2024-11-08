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

ActiveRecord::Schema[7.2].define(version: 2024_11_08_161910) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "family_groups", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "medical_histories", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "disease", null: false
    t.string "treatment_status"
    t.integer "age_at_diagnosis"
    t.text "disease_notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_family_groups", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "family_group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["family_group_id"], name: "index_user_family_groups_on_family_group_id"
    t.index ["user_id"], name: "index_user_family_groups_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "uid"
    t.date "birth_date"
    t.string "gender"
    t.integer "blood_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["uid"], name: "index_users_on_uid", unique: true
  end

  add_foreign_key "medical_histories", "users"
end
