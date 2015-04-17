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

ActiveRecord::Schema.define(version: 20150417145210) do

  create_table "playlists", force: :cascade do |t|
    t.string   "name"
    t.integer  "host_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "requests", force: :cascade do |t|
    t.integer "song_id"
    t.integer "listener_id"
    t.integer "playlist_id"
  end

  create_table "songs", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "url"
    t.string   "uid"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "uid"
    t.string   "provider"
    t.string   "nickname"
    t.string   "profile_image"
    t.string   "profile_url"
    t.string   "token"
    t.string   "secret"
  end

end
