# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_10_02_180846) do
  create_table "items", force: :cascade do |t|
    t.string "url"
    t.string "var_name"
    t.string "distinguer"
    t.string "path"
    t.string "wanted_value"
    t.integer "notification_model_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["notification_model_id"], name: "index_items_on_notification_model_id"
  end

  create_table "listens", force: :cascade do |t|
    t.string "name"
    t.string "element_indentifier"
    t.integer "site_id"
    t.integer "notification_model_id"
    t.integer "model_task_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["model_task_id"], name: "index_listens_on_model_task_id"
    t.index ["notification_model_id"], name: "index_listens_on_notification_model_id"
    t.index ["site_id"], name: "index_listens_on_site_id"
  end

  create_table "logs", force: :cascade do |t|
    t.text "message_log"
    t.datetime "at"
  end

  create_table "model_tasks", force: :cascade do |t|
    t.string "content"
    t.string "file_name"
    t.integer "listen_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["listen_id"], name: "index_model_tasks_on_listen_id"
  end

  create_table "notification_models", force: :cascade do |t|
    t.text "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "queued_tasks", force: :cascade do |t|
    t.string "content"
    t.string "file_name"
    t.integer "state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reports", force: :cascade do |t|
    t.text "current_state"
    t.integer "listen_id"
    t.datetime "at"
    t.index ["listen_id"], name: "index_reports_on_listen_id"
  end

  create_table "sites", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "telegram_token"
    t.string "telegram_chatid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
