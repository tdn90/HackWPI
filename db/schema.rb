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

ActiveRecord::Schema.define(version: 2019_01_19_231419) do

  create_table "assigntables", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "line_item_id"
    t.integer "user_id"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["line_item_id", "user_id"], name: "index_assigntables_on_line_item_id_and_user_id"
  end

  create_table "groups", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "admin_id", null: false
    t.bigint "payperiod_id"
    t.string "name"
    t.index ["admin_id"], name: "index_groups_on_admin_id"
    t.index ["payperiod_id"], name: "index_groups_on_payperiod_id"
  end

  create_table "groups_users", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "group_id", null: false
    t.index ["user_id", "group_id"], name: "index_groups_users_on_user_id_and_group_id"
  end

  create_table "line_items", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "receipt_id", null: false
    t.string "item", default: "", null: false
    t.float "price", default: 0.0, null: false
    t.index ["receipt_id"], name: "index_line_items_on_receipt_id"
  end

  create_table "payperiods", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.datetime "start", null: false
    t.datetime "end", null: false
    t.text "resultJson", null: false
    t.boolean "archived", null: false
    t.bigint "group_id", null: false
    t.index ["group_id"], name: "index_payperiods_on_group_id"
  end

  create_table "receipts", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.text "description"
    t.bigint "user_id", null: false
    t.boolean "paid", default: false, null: false
    t.datetime "created_at"
    t.bigint "group_id"
    t.bigint "payperiod_id"
    t.index ["group_id"], name: "index_receipts_on_group_id"
    t.index ["payperiod_id"], name: "index_receipts_on_payperiod_id"
    t.index ["user_id"], name: "index_receipts_on_user_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "authentication_token", limit: 30
    t.index ["authentication_token"], name: "index_users_on_authentication_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "groups", "payperiods"
  add_foreign_key "groups", "users", column: "admin_id"
  add_foreign_key "line_items", "receipts"
  add_foreign_key "payperiods", "groups"
  add_foreign_key "receipts", "groups", on_delete: :cascade
  add_foreign_key "receipts", "payperiods", on_delete: :cascade
  add_foreign_key "receipts", "users"
end
