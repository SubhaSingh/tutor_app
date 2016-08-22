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

ActiveRecord::Schema.define(version: 20150925154952) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "assessment_tutors", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "assessment_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "assessments", force: :cascade do |t|
    t.string   "name"
    t.string   "venue"
    t.datetime "starttime"
    t.datetime "endtime"
    t.date     "date"
    t.text     "notes"
    t.integer  "user_id"
    t.integer  "course_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "assessments", ["created_at"], name: "index_assessments_on_created_at", using: :btree

  create_table "availabilities", force: :cascade do |t|
    t.integer  "course_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "calendars", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "contacts", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "subject"
    t.text     "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "convenors", force: :cascade do |t|
    t.integer  "course_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "courses", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "feedbacks", force: :cascade do |t|
    t.string   "role"
    t.decimal  "clarity",         precision: 4, scale: 2, default: 0.0
    t.decimal  "conciseness",     precision: 4, scale: 2, default: 0.0
    t.decimal  "familiarity",     precision: 4, scale: 2, default: 0.0
    t.decimal  "responsiveness",  precision: 4, scale: 2, default: 0.0
    t.decimal  "consistency",     precision: 4, scale: 2, default: 0.0
    t.decimal  "attractiveness",  precision: 4, scale: 2, default: 0.0
    t.decimal  "efficiency",      precision: 4, scale: 2, default: 0.0
    t.decimal  "forgiving",       precision: 4, scale: 2, default: 0.0
    t.decimal  "informativeness", precision: 4, scale: 2, default: 0.0
    t.decimal  "devices",         precision: 4, scale: 2, default: 0.0
    t.text     "comments"
    t.datetime "created_at",                                            null: false
    t.datetime "updated_at",                                            null: false
  end

  create_table "invites", force: :cascade do |t|
    t.string   "email"
    t.integer  "course_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "lecturers", force: :cascade do |t|
    t.integer  "course_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "meeting_members", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "meeting_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "meetings", force: :cascade do |t|
    t.string   "name"
    t.string   "venue"
    t.datetime "starttime"
    t.datetime "endtime"
    t.date     "date"
    t.text     "notes"
    t.integer  "course_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "meetings", ["created_at"], name: "index_meetings_on_created_at", using: :btree

  create_table "members", force: :cascade do |t|
    t.integer  "course_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "posts", force: :cascade do |t|
    t.text     "content"
    t.integer  "course_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "posts", ["course_id"], name: "index_posts_on_course_id", using: :btree
  add_index "posts", ["created_at"], name: "index_posts_on_created_at", using: :btree
  add_index "posts", ["user_id"], name: "index_posts_on_user_id", using: :btree

  create_table "solutions", force: :cascade do |t|
    t.integer  "course_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.integer  "user_id"
    t.string   "answer_file_name"
    t.string   "answer_content_type"
    t.integer  "answer_file_size"
    t.datetime "answer_updated_at"
  end

  add_index "solutions", ["created_at"], name: "index_solutions_on_created_at", using: :btree

  create_table "students", force: :cascade do |t|
    t.string   "name"
    t.string   "student_number"
    t.boolean  "attendance",                             default: false
    t.boolean  "task_completed",                         default: false
    t.decimal  "mark",           precision: 5, scale: 2, default: 0.0
    t.integer  "assessment_id"
    t.integer  "user_id"
    t.datetime "created_at",                                             null: false
    t.datetime "updated_at",                                             null: false
  end

  add_index "students", ["student_number"], name: "index_students_on_student_number", using: :btree

  create_table "tutor_informations", force: :cascade do |t|
    t.text     "content"
    t.integer  "user_id"
    t.integer  "course_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "tutor_informations", ["user_id"], name: "index_tutor_informations_on_user_id", using: :btree

  create_table "tutors", force: :cascade do |t|
    t.integer  "course_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "password_digest"
    t.string   "remember_digest"
    t.boolean  "superadmin",          default: false
    t.string   "activation_digest"
    t.boolean  "activated"
    t.datetime "activated_at"
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

  add_foreign_key "assessment_tutors", "assessments"
  add_foreign_key "assessment_tutors", "users"
  add_foreign_key "assessments", "courses"
  add_foreign_key "assessments", "users"
  add_foreign_key "availabilities", "courses"
  add_foreign_key "convenors", "courses"
  add_foreign_key "convenors", "users"
  add_foreign_key "invites", "courses"
  add_foreign_key "lecturers", "courses"
  add_foreign_key "lecturers", "users"
  add_foreign_key "meeting_members", "meetings"
  add_foreign_key "meeting_members", "users"
  add_foreign_key "meetings", "courses"
  add_foreign_key "meetings", "users"
  add_foreign_key "members", "courses"
  add_foreign_key "posts", "courses"
  add_foreign_key "posts", "users"
  add_foreign_key "solutions", "courses"
  add_foreign_key "solutions", "users"
  add_foreign_key "students", "assessments"
  add_foreign_key "students", "users"
  add_foreign_key "tutor_informations", "courses"
  add_foreign_key "tutor_informations", "users"
  add_foreign_key "tutors", "courses"
  add_foreign_key "tutors", "users"
end
