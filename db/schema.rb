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

ActiveRecord::Schema.define(:version => 20130110035723) do

  create_table "teams", :force => true do |t|
    t.integer  "user1_id"
    t.integer  "user2_id"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "teams", ["user1_id"], :name => "index_teams_on_user1_id"
  add_index "teams", ["user2_id"], :name => "index_teams_on_user2_id"

  create_table "users", :force => true do |t|
    t.string   "tagline"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.string   "remember_token"
    t.string   "google_id"
    t.string   "google_token"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "google_hd"
    t.string   "google_image_url"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

end
