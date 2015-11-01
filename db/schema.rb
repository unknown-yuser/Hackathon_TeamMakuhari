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

ActiveRecord::Schema.define(version: 20151031095348) do

  create_table "link_nodes", force: :cascade do |t|
    t.string   "link_id"
    t.string   "node_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "link_nodes", ["link_id"], name: "index_link_nodes_on_link_id"
  add_index "link_nodes", ["node_id"], name: "index_link_nodes_on_node_id"

  create_table "links", force: :cascade do |t|
    t.string   "link_id"
    t.string   "src_node_id"
    t.string   "dst_node_id"
    t.integer  "link_type"
    t.integer  "width"
    t.float    "hill"
    t.integer  "gap"
    t.string   "gap_latitude"
    t.string   "gap_longitude"
    t.integer  "steps"
    t.integer  "bus_stop"
    t.string   "bus_stop_latitude"
    t.string   "bus_stop_longitude"
    t.integer  "blind_guide"
    t.integer  "signals"
    t.string   "street_name"
    t.float    "length"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "nodes", force: :cascade do |t|
    t.string   "node_id"
    t.string   "latitude"
    t.string   "longitude"
    t.string   "link_1"
    t.string   "link_2"
    t.string   "link_3"
    t.string   "link_4"
    t.string   "link_5"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
