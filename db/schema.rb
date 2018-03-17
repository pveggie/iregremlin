# frozen_string_literal: true

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

ActiveRecord::Schema.define(version: 20161004113028) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cells", force: :cascade do |t|
    t.integer  "puzzle_id"
    t.integer  "row_number"
    t.integer  "column_number"
    t.string   "content"
    t.string   "content_type"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["puzzle_id"], name: "index_cells_on_puzzle_id", using: :btree
  end

  create_table "puzzles", force: :cascade do |t|
    t.integer  "number"
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "enemies"
  end

  add_foreign_key "cells", "puzzles"
end
