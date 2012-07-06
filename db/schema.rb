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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120706140923) do

  create_table "games", :force => true do |t|
    t.string   "name"
    t.string   "server"
    t.integer  "port"
    t.integer  "status_cd"
    t.integer  "era_cd"
    t.integer  "provinces"
    t.integer  "max_players"
    t.boolean  "requires_passwords"
    t.string   "timer"
    t.integer  "turn_number"
    t.integer  "players_remaining"
    t.datetime "host_time"
    t.datetime "last_poll"
    t.text     "message"
    t.string   "map_preview"
    t.string   "map_download"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.integer  "host_id"
  end

  create_table "players", :force => true do |t|
    t.integer  "user_id"
    t.integer  "forum_id"
    t.string   "avatar"
    t.string   "aim"
    t.string   "icq"
    t.string   "xfire"
    t.string   "googletalk"
    t.string   "yahoo_messenger"
    t.string   "steam"
    t.string   "msn_messenger"
    t.string   "other"
    t.integer  "timezone"
    t.boolean  "email_pref"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "signups", :force => true do |t|
    t.integer  "game_id"
    t.integer  "nation_id"
    t.integer  "user_id"
    t.boolean  "password"
    t.string   "status"
    t.boolean  "turn"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "username",                        :null => false
    t.string   "email"
    t.string   "crypted_password"
    t.string   "salt"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.string   "remember_me_token"
    t.datetime "remember_me_token_expires_at"
    t.string   "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
  end

  add_index "users", ["remember_me_token"], :name => "index_users_on_remember_me_token"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token"

end
