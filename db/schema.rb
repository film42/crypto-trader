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

ActiveRecord::Schema.define(:version => 20131127082327) do

  create_table "currencies", :force => true do |t|
    t.decimal  "last",           :precision => 20, :scale => 5
    t.decimal  "average",        :precision => 20, :scale => 5
    t.decimal  "volume",         :precision => 20, :scale => 5
    t.decimal  "volume_current", :precision => 20, :scale => 5
    t.decimal  "high",           :precision => 20, :scale => 5
    t.decimal  "low",            :precision => 20, :scale => 5
    t.string   "pair",                                          :null => false
    t.datetime "created_at",                                    :null => false
    t.datetime "updated_at",                                    :null => false
    t.decimal  "buy",            :precision => 20, :scale => 5
    t.decimal  "sell",           :precision => 20, :scale => 5
  end

  create_table "exchanges", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "transactions", :force => true do |t|
    t.decimal  "buy_amount",          :precision => 20, :scale => 5
    t.decimal  "buy_rate_usd",        :precision => 20, :scale => 5
    t.string   "buy_currency_code"
    t.decimal  "using_rate_usd",      :precision => 20, :scale => 5
    t.string   "using_currency_code"
    t.decimal  "total",               :precision => 20, :scale => 5
    t.decimal  "total_usd",           :precision => 20, :scale => 5
    t.decimal  "new_balance",         :precision => 20, :scale => 5
    t.datetime "created_at",                                         :null => false
    t.datetime "updated_at",                                         :null => false
    t.integer  "user_id"
    t.string   "status"
    t.decimal  "service_charge",      :precision => 20, :scale => 5
  end

  create_table "users", :force => true do |t|
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
    t.string   "username",                               :null => false
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["username"], :name => "index_users_on_username", :unique => true

  create_table "wallets", :force => true do |t|
    t.decimal  "ltc_balance", :precision => 20, :scale => 5
    t.decimal  "usd_balance", :precision => 20, :scale => 5
    t.integer  "user_id"
    t.datetime "created_at",                                 :null => false
    t.datetime "updated_at",                                 :null => false
    t.decimal  "nmc_balance", :precision => 20, :scale => 5
    t.decimal  "btc_balance", :precision => 20, :scale => 5
  end

end
