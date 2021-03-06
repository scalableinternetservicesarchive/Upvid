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

ActiveRecord::Schema.define(version: 20141215033555) do

  create_table "comments", force: true do |t|
    t.text     "message"
    t.integer  "video_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["user_id"], name: "index_comments_on_user_id"
  add_index "comments", ["video_id"], name: "index_comments_on_video_id"

  create_table "delayed_jobs", force: true do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority"

  create_table "favorite_videos", force: true do |t|
    t.string   "video_id"
    t.string   "integer"
    t.string   "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "local_videofiles", force: true do |t|
    t.integer "video_id"
    t.string  "style"
    t.binary  "file_contents"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "users_videos", id: false, force: true do |t|
    t.integer "video_id", null: false
    t.integer "user_id",  null: false
  end

  add_index "users_videos", ["user_id", "video_id"], name: "index_users_videos_on_user_id_and_video_id"
  add_index "users_videos", ["video_id", "user_id"], name: "index_users_videos_on_video_id_and_user_id"

  create_table "videos", force: true do |t|
    t.string   "title"
    t.string   "category"
    t.string   "location"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "videofile_file_name"
    t.string   "videofile_content_type"
    t.integer  "videofile_file_size"
    t.datetime "videofile_updated_at"
    t.string   "local_videofile_file_name"
    t.string   "local_videofile_content_type"
    t.integer  "local_videofile_file_size"
    t.datetime "local_videofile_updated_at"
  end

  add_index "videos", ["user_id"], name: "index_videos_on_user_id"

end
