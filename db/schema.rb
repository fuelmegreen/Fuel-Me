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

ActiveRecord::Schema.define(:version => 20120825111958) do

  create_table "accounts", :force => true do |t|
    t.integer  "user_id"
    t.string   "provider",   :limit => 64, :null => false
    t.string   "uid",                      :null => false
    t.string   "username",   :limit => 64
    t.string   "avatar"
    t.string   "email"
    t.string   "token"
    t.string   "secret"
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  add_index "accounts", ["email"], :name => "index_accounts_on_email"
  add_index "accounts", ["provider"], :name => "index_accounts_on_provider"
  add_index "accounts", ["uid"], :name => "index_accounts_on_uid"
  add_index "accounts", ["user_id"], :name => "index_accounts_on_user_id"
  add_index "accounts", ["username"], :name => "index_accounts_on_username"

  create_table "blog_comments", :force => true do |t|
    t.integer  "post_id"
    t.string   "name"
    t.string   "email"
    t.string   "url"
    t.string   "ip"
    t.string   "user_agent"
    t.boolean  "can_post"
    t.string   "referrer"
    t.string   "state"
    t.text     "body"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "blog_comments", ["email"], :name => "index_comments_on_email"
  add_index "blog_comments", ["post_id"], :name => "index_comments_on_post_id"

  create_table "blog_posts", :force => true do |t|
    t.integer  "author_id"
    t.string   "title"
    t.string   "state"
    t.datetime "published_at"
    t.string   "permalink"
    t.text     "body"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "blog_posts", ["author_id"], :name => "index_posts_on_author_id"
  add_index "blog_posts", ["permalink"], :name => "index_posts_on_permalink"

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "photos", :force => true do |t|
    t.integer "user_id"
    t.string  "name",        :limit => 64, :null => false
    t.string  "description"
    t.string  "image"
  end

  add_index "photos", ["user_id"], :name => "index_photos_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "first_name",             :limit => 64,                 :null => false
    t.string   "last_name",              :limit => 64
    t.string   "avatar"
    t.string   "bio"
    t.text     "preferences"
    t.string   "username",               :limit => 64,                 :null => false
    t.string   "email",                                                :null => false
    t.string   "encrypted_password",                   :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                        :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at",                                           :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["username"], :name => "index_users_on_username", :unique => true

end
