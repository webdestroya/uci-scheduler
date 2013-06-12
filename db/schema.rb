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

ActiveRecord::Schema.define(:version => 20130612215115) do

  create_table "buildings", :force => true do |t|
    t.string   "abbr",       :null => false
    t.string   "name",       :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "buildings", ["abbr"], :name => "index_buildings_on_abbr", :unique => true

  create_table "course_names", :force => true do |t|
    t.integer  "term_id",       :null => false
    t.integer  "department_id", :null => false
    t.string   "course_number", :null => false
    t.string   "name",          :null => false
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "course_names", ["department_id", "course_number"], :name => "index_course_names_on_department_id_and_course_number"
  add_index "course_names", ["term_id"], :name => "index_course_names_on_term_id"

  create_table "courses", :force => true do |t|
    t.integer  "term_id",                                        :null => false
    t.integer  "course_name_id",                                 :null => false
    t.integer  "ccode",                                          :null => false
    t.string   "type",           :limit => 3, :default => "LEC", :null => false
    t.datetime "start_time",                                     :null => false
    t.datetime "end_time",                                       :null => false
    t.boolean  "monday",                      :default => false, :null => false
    t.boolean  "tuesday",                     :default => false, :null => false
    t.boolean  "wednesday",                   :default => false, :null => false
    t.boolean  "thursday",                    :default => false, :null => false
    t.boolean  "friday",                      :default => false, :null => false
    t.boolean  "saturday",                    :default => false, :null => false
    t.boolean  "sunday",                      :default => false, :null => false
    t.string   "teacher",                                        :null => false
    t.integer  "building_id",                                    :null => false
    t.string   "room",                                           :null => false
    t.string   "status"
    t.datetime "created_at",                                     :null => false
    t.datetime "updated_at",                                     :null => false
  end

  add_index "courses", ["course_name_id"], :name => "index_courses_on_course_name_id"
  add_index "courses", ["status"], :name => "index_courses_on_status"
  add_index "courses", ["term_id"], :name => "index_courses_on_term_id"

  create_table "departments", :force => true do |t|
    t.string "code", :null => false
    t.string "name", :null => false
  end

  add_index "departments", ["code"], :name => "index_departments_on_code", :unique => true

  create_table "terms", :force => true do |t|
    t.string   "code",                          :null => false
    t.string   "name",                          :null => false
    t.boolean  "current",    :default => false, :null => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  add_index "terms", ["code"], :name => "index_terms_on_code", :unique => true
  add_index "terms", ["current"], :name => "index_terms_on_current"

end
