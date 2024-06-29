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

ActiveRecord::Schema[7.0].define(version: 2024_06_29_194130) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "crons", force: :cascade do |t|
    t.string "name"
    t.string "interval"
    t.string "next_run"
    t.bigint "model_task_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "params"
    t.index ["model_task_id"], name: "index_crons_on_model_task_id"
  end

  create_table "items", force: :cascade do |t|
    t.string "url", null: false
    t.string "var_name", null: false
    t.boolean "islast", default: false
    t.string "path", null: false
    t.string "wanted_value", null: false
    t.bigint "notification_model_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["notification_model_id"], name: "index_items_on_notification_model_id"
  end

  create_table "listens", force: :cascade do |t|
    t.string "name", null: false
    t.text "url", null: false
    t.bigint "site_id", null: false
    t.bigint "notification_model_id"
    t.bigint "model_task_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "model_tasks_id"
    t.text "script"
    t.integer "interval"
    t.string "next_run"
    t.index ["model_task_id"], name: "index_listens_on_model_task_id"
    t.index ["model_tasks_id"], name: "index_listens_on_model_tasks_id"
    t.index ["notification_model_id"], name: "index_listens_on_notification_model_id"
    t.index ["site_id"], name: "index_listens_on_site_id"
  end

  create_table "log_tasks", force: :cascade do |t|
    t.text "content"
    t.string "file_name"
    t.integer "state", default: 2
    t.integer "count_erro", default: 0
    t.datetime "initialized_at"
    t.datetime "terminated_at", null: false
    t.text "log"
    t.datetime "updated_at"
    t.text "preset_content"
  end

  create_table "logs", force: :cascade do |t|
    t.text "message_log"
    t.datetime "at"
  end

  create_table "model_tasks", force: :cascade do |t|
    t.text "content", null: false
    t.string "file_name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "preset_content"
  end

  create_table "notification_models", force: :cascade do |t|
    t.text "message", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "queued_tasks", force: :cascade do |t|
    t.text "content", null: false
    t.string "file_name", null: false
    t.integer "state", default: 0
    t.text "log"
    t.integer "count_erro", default: 0
    t.datetime "initialized_at"
    t.datetime "updated_at"
    t.text "preset_content"
    t.text "message_error"
    t.text "params"
  end

  create_table "reports", force: :cascade do |t|
    t.text "current_state", null: false
    t.bigint "listen_id", null: false
    t.datetime "at", null: false
    t.index ["listen_id"], name: "index_reports_on_listen_id"
  end

  create_table "sites", force: :cascade do |t|
    t.string "name", null: false
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.text "telegram_token"
    t.string "telegram_chatid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "crons", "model_tasks"
  add_foreign_key "listens", "model_tasks", column: "model_tasks_id"
end
