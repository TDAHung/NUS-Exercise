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

ActiveRecord::Schema[7.0].define(version: 2023_07_11_083812) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "album_attachments", force: :cascade do |t|
    t.bigint "album_id"
    t.string "img_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["album_id"], name: "index_album_attachments_on_album_id"
  end

  create_table "albums", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.boolean "is_public", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_albums_on_user_id"
  end

  create_table "followers", id: false, force: :cascade do |t|
    t.bigint "follower_id", null: false
    t.bigint "following_user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["follower_id", "following_user_id"], name: "unique_follower_following_user_index", unique: true
    t.index ["follower_id"], name: "index_followers_on_follower_id"
    t.index ["following_user_id"], name: "index_followers_on_following_user_id"
  end

  create_table "likes", id: false, force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "likeable_type", null: false
    t.bigint "likeable_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["likeable_type", "likeable_id"], name: "index_likes_on_likeable"
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "photos", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.boolean "is_public", null: false
    t.string "img_url", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_photos_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "first_name", null: false
    t.string "last_name"
    t.string "password_digest", null: false
    t.string "img_url"
    t.boolean "is_admin", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 0, null: false
  end

  add_foreign_key "album_attachments", "albums"
  add_foreign_key "albums", "users"
  add_foreign_key "followers", "users", column: "follower_id"
  add_foreign_key "followers", "users", column: "following_user_id"
  add_foreign_key "likes", "users"
  add_foreign_key "photos", "users"
end
