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

ActiveRecord::Schema.define(version: 20190310100940) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "projects", force: :cascade do |t|
    t.string "lot"
    t.string "address"
    t.string "office"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "estate"
    t.string "client_name"
    t.string "solicitor"
    t.string "builder"
    t.boolean "firb"
    t.string "property_status"
  end

  create_table "settlements", force: :cascade do |t|
    t.datetime "title_registered_date"
    t.datetime "estimated_settlement_date"
    t.datetime "planned_settlement_date"
    t.datetime "final_settlement_date"
    t.string "funds_type"
    t.string "broker"
    t.bigint "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "property_type"
    t.index ["project_id"], name: "index_settlements_on_project_id"
  end

  add_foreign_key "settlements", "projects"
end
