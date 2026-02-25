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

ActiveRecord::Schema[8.0].define(version: 2026_02_25_154658) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "affiliate_domains", force: :cascade do |t|
    t.bigint "affiliate_id", null: false
    t.string "domain"
    t.string "verification_method"
    t.string "verification_token"
    t.datetime "verified_at"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["affiliate_id"], name: "index_affiliate_domains_on_affiliate_id"
  end

  create_table "affiliates", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "status"
    t.string "referral_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["referral_code"], name: "index_affiliates_on_referral_code", unique: true
  end

  create_table "clicks", force: :cascade do |t|
    t.bigint "affiliate_id", null: false
    t.bigint "offer_id", null: false
    t.bigint "affiliate_domain_id", null: false
    t.string "referral_code"
    t.string "ip"
    t.text "user_agent"
    t.text "referer"
    t.string "request_id"
    t.datetime "clicked_at"
    t.jsonb "raw_metadata"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["affiliate_domain_id"], name: "index_clicks_on_affiliate_domain_id"
    t.index ["affiliate_id"], name: "index_clicks_on_affiliate_id"
    t.index ["offer_id"], name: "index_clicks_on_offer_id"
  end

  create_table "conversions", force: :cascade do |t|
    t.bigint "affiliate_id", null: false
    t.bigint "offer_id", null: false
    t.bigint "click_id", null: false
    t.string "external_order_id"
    t.integer "amount_cents"
    t.string "currency"
    t.string "status"
    t.datetime "attributed_at"
    t.jsonb "raw_metadata"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["affiliate_id"], name: "index_conversions_on_affiliate_id"
    t.index ["click_id"], name: "index_conversions_on_click_id"
    t.index ["offer_id"], name: "index_conversions_on_offer_id"
  end

  create_table "offers", force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.integer "payout_cents"
    t.string "currency"
    t.string "status"
    t.integer "attribution_window_seconds"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "payout_items", force: :cascade do |t|
    t.bigint "payout_id", null: false
    t.bigint "conversion_id", null: false
    t.integer "amount_cents"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["conversion_id"], name: "index_payout_items_on_conversion_id"
    t.index ["payout_id"], name: "index_payout_items_on_payout_id"
  end

  create_table "payouts", force: :cascade do |t|
    t.bigint "affiliate_id", null: false
    t.datetime "period_start"
    t.datetime "period_end"
    t.string "status"
    t.integer "total_conversions"
    t.integer "total_amount_cents"
    t.string "currency"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["affiliate_id"], name: "index_payouts_on_affiliate_id"
  end

  add_foreign_key "affiliate_domains", "affiliates"
  add_foreign_key "clicks", "affiliate_domains"
  add_foreign_key "clicks", "affiliates"
  add_foreign_key "clicks", "offers"
  add_foreign_key "conversions", "affiliates"
  add_foreign_key "conversions", "clicks"
  add_foreign_key "conversions", "offers"
  add_foreign_key "payout_items", "conversions"
  add_foreign_key "payout_items", "payouts"
  add_foreign_key "payouts", "affiliates"
end
