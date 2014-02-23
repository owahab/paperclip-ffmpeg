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

ActiveRecord::Schema.define(version: 20131210144101) do

  create_table "videos", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "clip_file_name"
    t.string   "clip_content_type"
    t.integer  "clip_file_size"
    t.datetime "clip_updated_at"
    t.string   "wrongClip_file_name"
    t.string   "wrongClip_content_type"
    t.integer  "wrongClip_file_size"
    t.datetime "wrongClip_updated_at"
    t.string   "clip_thumb_exceed_file_name"
    t.string   "clip_thumb_exceed_content_type"
    t.integer  "clip_thumb_exceed_file_size"
    t.datetime "clip_thumb_exceed_updated_at"
    t.string   "clip_thumb_normal_file_name"
    t.string   "clip_thumb_normal_content_type"
    t.integer  "clip_thumb_normal_file_size"
    t.datetime "clip_thumb_normal_updated_at"
    t.string   "clip_thumb_negative_file_name"
    t.string   "clip_thumb_negative_content_type"
    t.integer  "clip_thumb_negative_file_size"
    t.datetime "clip_thumb_negative_updated_at"
    t.string   "clip_thumb_bad_extension_file_name"
    t.string   "clip_thumb_bad_extension_content_type"
    t.integer  "clip_thumb_bad_extension_file_size"
    t.datetime "clip_thumb_bad_extension_updated_at"
  end

end
