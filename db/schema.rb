# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20141123221159) do

  create_table "directors", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "genres", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "locations", force: :cascade do |t|
    t.string   "address",    limit: 255
    t.float    "latitude"
    t.float    "longitude"
    t.string   "comment",    limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "movie_director_infos", force: :cascade do |t|
    t.integer  "movie_id"
    t.integer  "director_id"
    t.string   "comment",     limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "movie_director_infos", ["movie_id", "director_id"], name: "index_movie_director_infos_on_movie_id_and_director_id"

  create_table "movie_genre_infos", force: :cascade do |t|
    t.string   "comment",    limit: 255
    t.integer  "movie_id"
    t.integer  "genre_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "movie_genre_infos", ["movie_id", "genre_id"], name: "index_movie_genre_infos_on_movie_id_and_genre_id"

  create_table "movie_location_infos", force: :cascade do |t|
    t.integer  "movie_id"
    t.integer  "location_id"
    t.string   "comment",     limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "movie_location_infos", ["movie_id", "location_id"], name: "index_movie_location_infos_on_movie_id_and_location_id"

  create_table "movies", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.string   "imdb_id",    limit: 255
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.string   "poster",     limit: 255
    t.string   "imdb_url",   limit: 255
    t.integer  "year"
    t.decimal  "rating",                 precision: 2
    t.integer  "box_office", limit: 1
  end

  add_index "movies", ["rating"], name: "index_movies_on_rating"
  add_index "movies", ["title", "imdb_id", "rating"], name: "index_movies_on_title_and_imdb_id_and_rating"

  create_table "users", force: :cascade do |t|
    t.string   "name",                   limit: 255, default: ""
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.string   "confirmation_token",     limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email",      limit: 255
    t.integer  "failed_attempts",                    default: 0
    t.string   "unlock_token",           limit: 255
    t.datetime "locked_at"
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "provider",               limit: 255
    t.string   "uid",                    limit: 255
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true

end
