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

ActiveRecord::Schema.define(version: 20140305161010) do

  create_table "cackle_comments", id: false, force: true do |t|
    t.integer  "comment_id"
    t.integer  "parent_id"
    t.string   "post_id"
    t.string   "url"
    t.string   "title"
    t.text     "message"
    t.string   "status"
    t.string   "ip"
    t.string   "author_name"
    t.string   "author_email"
    t.string   "author_avatar"
    t.string   "author_www"
    t.string   "author_provider"
    t.string   "anonym_name"
    t.string   "anonym_email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
