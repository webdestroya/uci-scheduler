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

ActiveRecord::Schema.define(:version => 20130619182218) do

  create_table "buildings", :force => true do |t|
    t.string   "abbr",       :null => false
    t.string   "name",       :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "buildings", ["abbr"], :name => "index_buildings_on_abbr", :unique => true

  create_table "courses", :force => true do |t|
    t.integer  "term_id",                                          :null => false
    t.integer  "parent_course_id"
    t.integer  "department_id",                                    :null => false
    t.string   "course_num",                                       :null => false
    t.string   "name",                                             :null => false
    t.integer  "ccode",                                            :null => false
    t.string   "section",                                          :null => false
    t.string   "type",             :limit => 3, :default => "LEC", :null => false
    t.time     "start_time",                                       :null => false
    t.time     "end_time",                                         :null => false
    t.boolean  "monday",                        :default => false, :null => false
    t.boolean  "tuesday",                       :default => false, :null => false
    t.boolean  "wednesday",                     :default => false, :null => false
    t.boolean  "thursday",                      :default => false, :null => false
    t.boolean  "friday",                        :default => false, :null => false
    t.boolean  "saturday",                      :default => false, :null => false
    t.boolean  "sunday",                        :default => false, :null => false
    t.string   "teacher",                                          :null => false
    t.integer  "building_id"
    t.string   "room"
    t.string   "status"
    t.datetime "created_at",                                       :null => false
    t.datetime "updated_at",                                       :null => false
  end

  add_index "courses", ["course_num"], :name => "index_courses_on_course_num"
  add_index "courses", ["department_id"], :name => "index_courses_on_department_id"
  add_index "courses", ["parent_course_id"], :name => "index_courses_on_parent_course_id"
  add_index "courses", ["status"], :name => "index_courses_on_status"
  add_index "courses", ["term_id", "ccode"], :name => "index_courses_on_term_id_and_ccode", :unique => true

  create_table "departments", :force => true do |t|
    t.string  "code",                      :null => false
    t.string  "name",                      :null => false
    t.boolean "active", :default => true,  :null => false
    t.boolean "large",  :default => false, :null => false
  end

  add_index "departments", ["active"], :name => "index_departments_on_active"
  add_index "departments", ["code"], :name => "index_departments_on_code", :unique => true

  create_table "search_courses", :force => true do |t|
    t.integer "search_id",     :null => false
    t.integer "department_id", :null => false
    t.string  "course_num",    :null => false
  end

  add_index "search_courses", ["search_id"], :name => "index_search_courses_on_search_id"

  create_table "searches", :force => true do |t|
    t.integer  "term_id",                            :null => false
    t.time     "start_time"
    t.time     "end_time"
    t.boolean  "monday",          :default => true,  :null => false
    t.boolean  "tuesday",         :default => true,  :null => false
    t.boolean  "wednesday",       :default => true,  :null => false
    t.boolean  "thursday",        :default => true,  :null => false
    t.boolean  "friday",          :default => true,  :null => false
    t.boolean  "saturday",        :default => false, :null => false
    t.boolean  "sunday",          :default => false, :null => false
    t.string   "statuses"
    t.text     "courses_list"
    t.string   "required_ccodes"
    t.string   "save_code"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
  end

  add_index "searches", ["save_code"], :name => "index_searches_on_save_code"

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
