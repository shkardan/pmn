# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110218081617) do

  create_table "accounts", :force => true do |t|
    t.integer  "frequency"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "discount"
  end

  create_table "calls", :force => true do |t|
    t.string   "sid"
    t.string   "from"
    t.string   "to"
    t.string   "status"
    t.string   "direction"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "body"
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "account_id"
  end

  create_table "coupons", :force => true do |t|
    t.integer  "user_id"
    t.string   "code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "deals", :force => true do |t|
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "messages", :force => true do |t|
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "sid"
    t.string   "date_created"
    t.string   "date_updated"
    t.string   "date_sent"
    t.string   "account_sid"
    t.string   "from"
    t.string   "to"
    t.string   "status"
    t.string   "direction"
    t.string   "price"
    t.string   "api_version"
    t.string   "uri"
    t.integer  "user_id"
    t.string   "discount"
    t.string   "name"
  end

  create_table "rights", :force => true do |t|
    t.string   "name"
    t.string   "controller"
    t.string   "action"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rights_roles", :id => false, :force => true do |t|
    t.integer "right_id"
    t.integer "role_id"
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "txts", :force => true do |t|
    t.string   "sid"
    t.string   "to"
    t.string   "from"
    t.text     "body"
    t.string   "direction"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status"
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "password_salt"
    t.string   "password_hash"
    t.string   "primarynumber"
    t.string   "areacode"
    t.string   "countrycode"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "fb_id"
    t.string   "email_hash"
  end

end
