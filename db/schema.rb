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

ActiveRecord::Schema.define(:version => 20130808023456) do

  create_table "coaches", :force => true do |t|
    t.string   "full_name"
    t.string   "bio"
    t.string   "picture_url"
    t.float    "work_percentage"
    t.integer  "user_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "roles", :force => true do |t|
    t.string   "key"
    t.string   "label"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "roles_users", :force => true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  create_table "users", :force => true do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "email"
    t.string   "image"
  end

  create_table "work_histories", :force => true do |t|
    t.integer  "work_id"
    t.string   "status"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "works", :force => true do |t|
    t.integer  "user_id"
    t.integer  "coach_id"
    t.string   "student_audience"
    t.string   "student_desired_outcome"
    t.string   "student_comment"
    t.string   "student_essence"
    t.string   "student_feedback"
    t.string   "coach_what_you_did"
    t.string   "coach_how_feel"
    t.string   "coach_homework"
    t.string   "coach_well"
    t.string   "coach_not_so_well"
    t.string   "coach_comment"
    t.string   "document_url"
    t.string   "youtube_url"
    t.boolean  "approved"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
    t.string   "google_file_id"
  end

end
