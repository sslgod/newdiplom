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

ActiveRecord::Schema.define(:version => 20120413221327) do

  create_table "kbodies", :force => true do |t|
    t.integer  "kplan_id"
    t.integer  "nomer_page"
    t.integer  "nomer_str"
    t.string   "nomer_uroka"
    t.string   "tema_zaniatia"
    t.string   "nomer_nedeli"
    t.integer  "kolvo_chasov"
    t.string   "vid_zaniatia"
    t.string   "nagl_posobie"
    t.string   "zadano"
    t.string   "samrab_casov"
    t.string   "samrab_zadanie"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "klits", :force => true do |t|
    t.integer  "kplan_id"
    t.integer  "nomer_srt"
    t.string   "literatura"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "kplans", :force => true do |t|
    t.integer  "user_id"
    t.integer  "predmet_comissia"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "ktitls", :force => true do |t|
    t.integer  "kplan_id"
    t.string   "pregmet"
    t.string   "spec"
    t.string   "group"
    t.string   "kurs"
    t.string   "semestr"
    t.string   "god"
    t.string   "uchregd"
    t.integer  "ch_ned"
    t.integer  "ch_zan"
    t.integer  "ch_labrab"
    t.integer  "ch_kprtk"
    t.integer  "ch_smr"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "nik"
    t.string   "name"
    t.string   "pas"
    t.string   "salt"
    t.integer  "tip"
    t.integer  "predmet_comissia"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "users", ["nik"], :name => "index_users_on_nik", :unique => true

end
