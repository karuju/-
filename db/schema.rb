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

ActiveRecord::Schema[7.0].define(version: 2024_01_04_064039) do
  create_table "artists", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.string "uri"
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "boards", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "title", null: false
    t.text "content"
    t.integer "status"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_boards_on_user_id"
  end

  create_table "comics", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "title", null: false
    t.string "author", null: false
    t.integer "category"
    t.text "summary"
    t.string "uri"
    t.string "publisher"
    t.date "published_year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "contents", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "contentable_id", null: false
    t.string "contentable_type", null: false
    t.bigint "post_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_contents_on_post_id"
  end

  create_table "movies", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "title", null: false
    t.string "director"
    t.string "leading_actor"
    t.integer "category"
    t.text "summary"
    t.string "distributer"
    t.date "published_year"
    t.string "uri"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "novels", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "title", null: false
    t.string "author", null: false
    t.integer "category"
    t.text "summary"
    t.string "uri"
    t.string "publisher"
    t.date "published_year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "post_songs", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "post_id"
    t.bigint "song_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_post_songs_on_post_id"
    t.index ["song_id"], name: "index_post_songs_on_song_id"
  end

  create_table "posts", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "title", null: false
    t.string "content"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "songs", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.string "uri"
    t.string "image"
    t.date "release_date"
    t.bigint "artist_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["artist_id"], name: "index_songs_on_artist_id"
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "image"
    t.text "introduction"
    t.integer "sex"
    t.date "birthday"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "crypted_password"
    t.string "salt"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "boards", "users"
  add_foreign_key "contents", "posts"
  add_foreign_key "post_songs", "posts"
  add_foreign_key "post_songs", "songs"
  add_foreign_key "posts", "users"
  add_foreign_key "songs", "artists"
end
