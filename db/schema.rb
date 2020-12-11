# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_12_10_140028) do

  create_table "active_storage_attachments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "machings", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", comment: "マッチングテーブル", force: :cascade do |t|
    t.bigint "request_user_id", comment: "リクエストしたユーザー"
    t.bigint "requested_user_id", comment: "リクエストされたユーザー"
    t.boolean "aggree", default: false, comment: "承諾可否"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["request_user_id", "requested_user_id"], name: "index_machings_on_request_user_id_and_requested_user_id", unique: true
    t.index ["request_user_id"], name: "index_machings_on_request_user_id"
    t.index ["requested_user_id"], name: "index_machings_on_requested_user_id"
  end

  create_table "messages", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.bigint "message_user_id", null: false, comment: "発言するユーザー"
    t.bigint "message_maching_id", comment: "紐づいているマッチング"
    t.text "message_content", comment: "メッセージの内容"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["message_maching_id"], name: "index_messages_on_message_maching_id"
    t.index ["message_user_id"], name: "index_messages_on_message_user_id"
  end

  create_table "notifications", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.bigint "notification_message_id", comment: "DMのメッセージ"
    t.bigint "notification_user_id", null: false, comment: "通知を受けるユーザー"
    t.bigint "notification_maching_id", comment: "DMしてる部屋"
    t.integer "notification_notification_type_id", null: false, comment: "お知らせの種類"
    t.boolean "notification_read", default: false, comment: "既読判定"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["notification_maching_id"], name: "index_notifications_on_notification_maching_id"
    t.index ["notification_message_id"], name: "index_notifications_on_notification_message_id"
    t.index ["notification_user_id"], name: "index_notifications_on_notification_user_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "machings", "users", column: "request_user_id"
  add_foreign_key "machings", "users", column: "requested_user_id"
  add_foreign_key "messages", "machings", column: "message_maching_id"
  add_foreign_key "notifications", "machings", column: "notification_maching_id"
  add_foreign_key "notifications", "messages", column: "notification_message_id"
end
