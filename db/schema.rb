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

ActiveRecord::Schema[7.0].define(version: 2023_03_16_111632) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "cards", force: :cascade do |t|
    t.boolean "guess"
    t.boolean "active", default: true
    t.bigint "character_id", null: false
    t.bigint "player_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "select", default: false
    t.index ["character_id"], name: "index_cards_on_character_id"
    t.index ["player_id"], name: "index_cards_on_player_id"
  end

  create_table "characteristic_questions", force: :cascade do |t|
    t.bigint "game_id", null: false
    t.bigint "player_id", null: false
    t.bigint "characteristic_id", null: false
    t.boolean "answer"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["characteristic_id"], name: "index_characteristic_questions_on_characteristic_id"
    t.index ["game_id"], name: "index_characteristic_questions_on_game_id"
    t.index ["player_id"], name: "index_characteristic_questions_on_player_id"
  end

  create_table "characteristics", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "characters", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "features", force: :cascade do |t|
    t.boolean "match"
    t.bigint "character_id", null: false
    t.bigint "characteristic_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["character_id"], name: "index_features_on_character_id"
    t.index ["characteristic_id"], name: "index_features_on_characteristic_id"
  end

  create_table "games", force: :cascade do |t|
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "creator"
  end

  create_table "players", force: :cascade do |t|
    t.boolean "winner"
    t.integer "score"
    t.string "chifoumi"
    t.boolean "current_player"
    t.integer "user_id"
    t.bigint "game_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_players_on_game_id"
    t.index ["user_id"], name: "index_players_on_user_id"
  end

  create_table "turns", force: :cascade do |t|
    t.integer "number"
    t.bigint "player_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "card_id"
    t.bigint "characteristic_id"
    t.index ["card_id"], name: "index_turns_on_card_id"
    t.index ["characteristic_id"], name: "index_turns_on_characteristic_id"
    t.index ["player_id"], name: "index_turns_on_player_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "nickname"
    t.integer "score", default: 0
    t.string "batch"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "cards", "characters"
  add_foreign_key "cards", "players"
  add_foreign_key "characteristic_questions", "characteristics"
  add_foreign_key "characteristic_questions", "games"
  add_foreign_key "characteristic_questions", "players"
  add_foreign_key "features", "characteristics"
  add_foreign_key "features", "characters"
  add_foreign_key "players", "games"
  add_foreign_key "players", "users"
  add_foreign_key "turns", "cards"
  add_foreign_key "turns", "characteristics"
  add_foreign_key "turns", "players"
end
