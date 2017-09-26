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

ActiveRecord::Schema.define(version: 20150507205335) do

  create_table "admin_hardware_types", force: true do |t|
    t.string   "model_number"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "admin_pay_programs", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.decimal  "price",       precision: 10, scale: 0
    t.boolean  "available"
    t.string   "period"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "campaigns", force: true do |t|
    t.string   "displayname"
    t.integer  "organization_id"
    t.string   "uuid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "campaigns", ["organization_id"], name: "index_campaigns_on_organization_id", using: :btree

  create_table "loop_assets", force: true do |t|
    t.string   "displayname"
    t.integer  "organization_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "uuid"
  end

  add_index "loop_assets", ["organization_id"], name: "index_loop_assets_on_organization_id", using: :btree

  create_table "loop_campaign_hooks", force: true do |t|
    t.integer  "loop_asset_id"
    t.integer  "campaign_id"
    t.string   "play_info"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "start_year",    limit: 2
    t.integer  "start_month",   limit: 1
    t.integer  "start_day",     limit: 1
    t.integer  "start_hour",    limit: 1
    t.integer  "start_minute",  limit: 1
    t.integer  "start_second",  limit: 1
    t.integer  "end_year",      limit: 2
    t.integer  "end_month",     limit: 1
    t.integer  "end_day",       limit: 1
    t.integer  "end_hour",      limit: 1
    t.integer  "end_minute",    limit: 1
    t.integer  "end_second",    limit: 1
    t.integer  "repeat_info",   limit: 1
  end

  add_index "loop_campaign_hooks", ["campaign_id"], name: "index_loop_campaign_hooks_on_campaign_id", using: :btree
  add_index "loop_campaign_hooks", ["loop_asset_id"], name: "index_loop_campaign_hooks_on_loop_asset_id", using: :btree

  create_table "media_assets", force: true do |t|
    t.integer  "organization_id"
    t.string   "displayname"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "asset_file_file_name"
    t.string   "asset_file_content_type"
    t.integer  "asset_file_file_size"
    t.datetime "asset_file_updated_at"
    t.string   "asset_file_meta"
    t.integer  "duration"
  end

  add_index "media_assets", ["organization_id"], name: "index_media_assets_on_organization_id", using: :btree

  create_table "organizations", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "phone"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "fname"
    t.string   "lname"
    t.string   "address1"
    t.string   "address2"
    t.string   "address3"
    t.string   "city"
    t.string   "province"
    t.string   "postalcode"
    t.string   "baddress1"
    t.string   "baddress2"
    t.string   "baddress3"
    t.string   "bcity"
    t.string   "bprovince"
    t.string   "bpostalcode"
  end

  create_table "players", force: true do |t|
    t.integer  "organization_id"
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "access_code"
    t.integer  "campaign_id"
    t.datetime "last_update_stamp"
    t.boolean  "activated"
    t.string   "uniqkey"
    t.string   "pending_action"
    t.integer  "admin_hardware_type_id"
    t.string   "serial_number"
    t.integer  "admin_pay_program_id"
    t.datetime "last_connection"
    t.text     "diagnostics"
  end

  add_index "players", ["admin_hardware_type_id"], name: "index_players_on_admin_hardware_type_id", using: :btree
  add_index "players", ["admin_pay_program_id"], name: "index_players_on_admin_pay_program_id", using: :btree
  add_index "players", ["campaign_id"], name: "index_players_on_campaign_id", using: :btree
  add_index "players", ["organization_id"], name: "index_players_on_organization_id", using: :btree

  create_table "slide_assets", force: true do |t|
    t.integer  "loop_asset_id"
    t.integer  "organization_id"
    t.integer  "slide_template_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "duration"
    t.integer  "position"
    t.string   "displayname"
    t.string   "uuid"
  end

  add_index "slide_assets", ["loop_asset_id"], name: "index_slide_assets_on_loop_asset_id", using: :btree
  add_index "slide_assets", ["organization_id"], name: "index_slide_assets_on_organization_id", using: :btree
  add_index "slide_assets", ["slide_template_id"], name: "index_slide_assets_on_slide_template_id", using: :btree

  create_table "slide_media_hooks", force: true do |t|
    t.integer  "organization_id"
    t.integer  "slide_asset_id"
    t.integer  "media_asset_id"
    t.string   "hook"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "slide_media_hooks", ["media_asset_id"], name: "index_slide_media_hooks_on_media_asset_id", using: :btree
  add_index "slide_media_hooks", ["organization_id"], name: "index_slide_media_hooks_on_organization_id", using: :btree
  add_index "slide_media_hooks", ["slide_asset_id"], name: "index_slide_media_hooks_on_slide_asset_id", using: :btree

  create_table "slide_string_hooks", force: true do |t|
    t.integer  "organization_id"
    t.integer  "slide_asset_id"
    t.text     "data"
    t.string   "hook"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "slide_string_hooks", ["organization_id"], name: "index_slide_string_hooks_on_organization_id", using: :btree
  add_index "slide_string_hooks", ["slide_asset_id"], name: "index_slide_string_hooks_on_slide_asset_id", using: :btree

  create_table "slide_templates", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.boolean  "listed"
    t.text     "markup"
    t.integer  "organization_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "hook_list"
  end

  add_index "slide_templates", ["organization_id"], name: "index_slide_templates_on_organization_id", using: :btree

  create_table "template_addons", force: true do |t|
    t.integer  "organization_id"
    t.string   "displayname"
    t.string   "hook"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
  end

  add_index "template_addons", ["organization_id"], name: "index_template_addons_on_organization_id", using: :btree

  create_table "user_logs", force: true do |t|
    t.integer  "organization_id"
    t.integer  "user_id"
    t.integer  "loggable_id"
    t.string   "loggable_type"
    t.text     "action"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_logs", ["loggable_id", "loggable_type"], name: "index_user_logs_on_loggable_id_and_loggable_type", using: :btree
  add_index "user_logs", ["organization_id"], name: "index_user_logs_on_organization_id", using: :btree
  add_index "user_logs", ["user_id"], name: "index_user_logs_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "remember_digest"
    t.boolean  "soadmin",                default: false
    t.integer  "organization_id"
    t.boolean  "orgadmin",               default: false
    t.integer  "default_slide_duration", default: 20000
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["organization_id"], name: "index_users_on_organization_id", using: :btree

end
