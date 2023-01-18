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

ActiveRecord::Schema[7.0].define(version: 2023_01_13_203815) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "distribution_settings", force: :cascade do |t|
    t.string "name", null: false
    t.string "mode", null: false
    t.string "allow_countries", default: [], null: false, array: true
    t.string "deny_countries", default: [], null: false, array: true
    t.bigint "owner_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_id"], name: "index_distribution_settings_on_owner_id"
  end

  create_table "organizations", force: :cascade do |t|
    t.string "name", null: false
    t.string "allow_countries", default: [], null: false, array: true
    t.string "deny_countries", default: [], null: false, array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "description", default: "", null: false
    t.string "country", null: false
    t.string "role", null: false
    t.bigint "organization_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organization_id"], name: "index_users_on_organization_id"
  end

  create_table "videos", force: :cascade do |t|
    t.string "name", null: false
    t.boolean "draft", default: true, null: false
    t.bigint "distribution_setting_id", null: false
    t.bigint "author_id", null: false
    t.string "read_allow_sids", default: [], null: false, array: true
    t.string "read_deny_sids", default: [], null: false, array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "index_videos_on_author_id"
    t.index ["distribution_setting_id"], name: "index_videos_on_distribution_setting_id"
    t.index ["read_allow_sids"], name: "index_videos_on_read_allow_sids"
    t.index ["read_deny_sids"], name: "index_videos_on_read_deny_sids"
  end

  add_foreign_key "distribution_settings", "users", column: "owner_id"
  add_foreign_key "users", "organizations"
  add_foreign_key "videos", "distribution_settings"
  add_foreign_key "videos", "users", column: "author_id"
end
