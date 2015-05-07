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

ActiveRecord::Schema.define(version: 20150507194521) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attached_files", force: :cascade do |t|
    t.string   "name"
    t.boolean  "is_active"
    t.integer  "attachable_id"
    t.string   "attachable_type"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.string   "attachable_document_file_name"
    t.string   "attachable_document_content_type"
    t.integer  "attachable_document_file_size"
    t.datetime "attachable_document_updated_at"
    t.boolean  "is_archived"
  end

  create_table "budget_items", force: :cascade do |t|
    t.string   "name"
    t.integer  "budget_amount"
    t.integer  "project_id"
    t.integer  "budgetable_id"
    t.string   "budgetable_type"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "budget_items", ["budgetable_id"], name: "index_budget_items_on_budgetable_id", using: :btree

  create_table "clearances", force: :cascade do |t|
    t.string   "name"
    t.integer  "clearance_status"
    t.date     "clearance_date"
    t.text     "comments"
    t.integer  "clearable_id"
    t.string   "clearable_type"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "comments", force: :cascade do |t|
    t.text     "comments"
    t.integer  "user_id"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.datetime "comment_date"
  end

  create_table "congressional_notifications", force: :cascade do |t|
    t.string   "name"
    t.string   "cn_number"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "old_id"
    t.string   "workflow_state"
  end

  create_table "congressional_notifications_projects", id: false, force: :cascade do |t|
    t.integer "congressional_notification_id"
    t.integer "project_id"
  end

  create_table "countries", force: :cascade do |t|
    t.string   "name"
    t.string   "iso2"
    t.string   "iso3"
    t.string   "boundary_type"
    t.text     "boundary_coordinates"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "old_id"
  end

  create_table "countries_projects", id: false, force: :cascade do |t|
    t.integer "country_id"
    t.integer "project_id"
  end

  create_table "countries_regions", id: false, force: :cascade do |t|
    t.integer "country_id"
    t.integer "region_id"
  end

  create_table "funding_mechanisms", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "name"
    t.integer  "old_id"
  end

  create_table "implementers", force: :cascade do |t|
    t.string   "name"
    t.string   "short_name"
    t.string   "parent_organization"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.integer  "old_id"
  end

  create_table "obligations", force: :cascade do |t|
    t.string   "obligation_number"
    t.integer  "obligation_amount"
    t.date     "obligation_date"
    t.integer  "fiscal_year"
    t.integer  "project_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "obligation_comments"
  end

  create_table "people", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "phone"
    t.string   "office"
    t.integer  "personable_id"
    t.string   "personable_type"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "people", ["personable_id"], name: "index_people_on_personable_id", using: :btree

  create_table "programs", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "old_id"
  end

  create_table "programs_users", id: false, force: :cascade do |t|
    t.integer "program_id"
    t.integer "user_id"
  end

  create_table "project_funding_mechanisms", force: :cascade do |t|
    t.integer  "project_id"
    t.integer  "funding_mechanism_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.string   "workflow_state"
  end

  create_table "project_implementers", force: :cascade do |t|
    t.integer  "project_id"
    t.integer  "implementer_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "description"
    t.string   "poc_name"
    t.string   "poc_email"
    t.string   "poc_phone"
    t.string   "poc_office"
  end

  create_table "projects", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "budget_requested"
    t.integer  "fiscal_year"
    t.text     "objective"
    t.text     "interest"
    t.text     "law_enforcement"
    t.text     "coordination"
    t.text     "lessons_learned"
    t.text     "sustainability"
    t.string   "city_province"
    t.string   "program_audience"
    t.boolean  "reprogram"
    t.text     "reprogram_comments"
    t.integer  "implementation_status"
    t.integer  "program_id"
    t.integer  "user_id"
    t.boolean  "is_archived"
    t.boolean  "is_denied"
    t.boolean  "is_active"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.integer  "old_id"
    t.string   "workflow_state"
    t.boolean  "do_renotify"
    t.boolean  "is_renotified"
    t.boolean  "is_funding_modified"
  end

  add_index "projects", ["workflow_state"], name: "index_projects_on_workflow_state", using: :btree

  create_table "projects_sub_accounts", id: false, force: :cascade do |t|
    t.integer "project_id"
    t.integer "sub_account_id"
  end

  create_table "regions", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "old_id"
    t.integer  "region_type"
    t.string   "abbreviation"
  end

  create_table "regions_users", id: false, force: :cascade do |t|
    t.integer "region_id"
    t.integer "user_id"
  end

  create_table "sub_accounts", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "old_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: ""
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "role"
    t.string   "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
    t.integer  "old_id"
    t.boolean  "is_active"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["invitation_token"], name: "index_users_on_invitation_token", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
