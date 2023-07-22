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

ActiveRecord::Schema[7.0].define(version: 2023_07_22_082748) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clients", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "address"
    t.string "description"
    t.string "name"
    t.string "phone_number"
    t.uuid "creator_id"
    t.uuid "last_updater_id"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["creator_id"], name: "index_clients_on_creator_id"
    t.index ["last_updater_id"], name: "index_clients_on_last_updater_id"
  end

  create_table "clients_jobs", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "client_id"
    t.uuid "job_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_clients_jobs_on_client_id"
    t.index ["job_id"], name: "index_clients_jobs_on_job_id"
  end

  create_table "jobs", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "description"
    t.string "name"
    t.integer "salary"
    t.integer "salary_currency", default: 0
    t.integer "working_hours"
    t.uuid "creator_id"
    t.uuid "last_updater_id"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["creator_id"], name: "index_jobs_on_creator_id"
    t.index ["last_updater_id"], name: "index_jobs_on_last_updater_id"
  end

  create_table "notifications", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "topic", default: 1
    t.text "content"
    t.uuid "creator_id"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["creator_id"], name: "index_notifications_on_creator_id"
  end

  create_table "shared_urls", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "url"
    t.uuid "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "movie_title"
    t.string "thumbnail_url"
    t.text "description"
    t.index ["user_id"], name: "index_shared_urls_on_user_id"
  end

  create_table "user_sessions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "session_token"
    t.string "login_ip"
    t.string "browser"
    t.uuid "user_id"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_user_sessions_on_user_id"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "email", null: false
    t.string "password_encrypted", null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role", default: 1
    t.integer "status", default: 0
    t.datetime "confirmed_at"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  create_table "users_notifications", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "read_at"
    t.uuid "user_id"
    t.uuid "notification_id"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["notification_id"], name: "index_users_notifications_on_notification_id"
    t.index ["user_id"], name: "index_users_notifications_on_user_id"
  end

end
