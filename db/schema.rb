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

ActiveRecord::Schema.define(:version => 20130605160643) do

  create_table "admins", :force => true do |t|
    t.string   "name"
    t.string   "mobile_number"
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "authentication_token"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "admins", ["authentication_token"], :name => "index_admins_on_authentication_token", :unique => true
  add_index "admins", ["confirmation_token"], :name => "index_admins_on_confirmation_token", :unique => true
  add_index "admins", ["email"], :name => "index_admins_on_email", :unique => true
  add_index "admins", ["reset_password_token"], :name => "index_admins_on_reset_password_token", :unique => true
  add_index "admins", ["unlock_token"], :name => "index_admins_on_unlock_token", :unique => true

  create_table "committee_emails", :force => true do |t|
    t.string   "email"
    t.string   "person"
    t.string   "mobile"
    t.boolean  "disabled"
    t.string   "created_by"
    t.string   "updated_by"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "event_type_item_details", :force => true do |t|
    t.integer  "item_id"
    t.integer  "event_type_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "event_types", :force => true do |t|
    t.string   "name"
    t.string   "display_name"
    t.string   "booked"
    t.text     "description"
    t.boolean  "disabled"
    t.string   "created_by"
    t.string   "updated_by"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "events", :force => true do |t|
    t.datetime "from_date_time"
    t.datetime "to_date_time"
    t.integer  "event_type_id"
    t.string   "booked_by"
    t.string   "booked"
    t.text     "description"
    t.boolean  "disabled"
    t.string   "created_by"
    t.string   "updated_by"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "item_types", :force => true do |t|
    t.string   "name"
    t.boolean  "disabled"
    t.string   "created_by"
    t.string   "updated_by"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "items", :force => true do |t|
    t.string   "name"
    t.integer  "item_type_id"
    t.text     "description"
    t.integer  "uom_id"
    t.boolean  "disabled"
    t.string   "created_by"
    t.string   "updated_by"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "notifications", :force => true do |t|
    t.datetime "date_time"
    t.string   "notification_type"
    t.string   "death_of"
    t.string   "place"
    t.text     "address"
    t.boolean  "disabled",          :default => false
    t.string   "created_by"
    t.string   "updated_by"
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
  end

  create_table "subject_email_details", :force => true do |t|
    t.integer  "visitor_mail_subject_id"
    t.integer  "committee_email_id"
    t.string   "receiver_type"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  create_table "uoms", :force => true do |t|
    t.string   "name"
    t.boolean  "disabled",   :default => false
    t.string   "created_by"
    t.string   "updated_by"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "visitor_mail_subjects", :force => true do |t|
    t.text     "subject"
    t.boolean  "disabled"
    t.string   "created_by"
    t.string   "updated_by"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "visitor_mails", :force => true do |t|
    t.string   "from_name"
    t.string   "from_email"
    t.string   "from_mobile"
    t.integer  "visitor_mail_subject_id"
    t.text     "message"
    t.text     "to_emails"
    t.boolean  "disabled"
    t.string   "created_by"
    t.string   "updated_by"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

end
