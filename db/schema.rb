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

ActiveRecord::Schema[7.1].define(version: 2024_05_24_164451) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "harvested_products", force: :cascade do |t|
    t.integer "amount"
    t.bigint "harvest_id", null: false
    t.bigint "offered_product_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "organization_id", null: false
    t.index ["harvest_id"], name: "index_harvested_products_on_harvest_id"
    t.index ["offered_product_id"], name: "index_harvested_products_on_offered_product_id"
    t.index ["organization_id"], name: "index_harvested_products_on_organization_id"
  end

  create_table "harvests", force: :cascade do |t|
    t.bigint "offering_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["offering_id"], name: "index_harvests_on_offering_id"
    t.index ["user_id"], name: "index_harvests_on_user_id"
  end

  create_table "locations", force: :cascade do |t|
    t.string "name"
    t.string "link"
    t.string "address"
    t.bigint "organization_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "pickup_place"
    t.boolean "active", default: true
    t.index ["organization_id"], name: "index_locations_on_organization_id"
  end

  create_table "offered_products", force: :cascade do |t|
    t.bigint "offering_id", null: false
    t.bigint "product_id", null: false
    t.integer "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "organization_id", null: false
    t.index ["offering_id"], name: "index_offered_products_on_offering_id"
    t.index ["organization_id"], name: "index_offered_products_on_organization_id"
    t.index ["product_id"], name: "index_offered_products_on_product_id"
  end

  create_table "offerings", force: :cascade do |t|
    t.datetime "opens_at"
    t.datetime "closes_at"
    t.date "harvest_at"
    t.bigint "location_id", null: false
    t.bigint "organization_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active", default: true, null: false
    t.index ["closes_at"], name: "index_offerings_on_closes_at"
    t.index ["location_id"], name: "index_offerings_on_location_id"
    t.index ["opens_at"], name: "index_offerings_on_opens_at"
    t.index ["organization_id"], name: "index_offerings_on_organization_id"
  end

  create_table "organizations", force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "main_usage"
    t.bigint "organization_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organization_id"], name: "index_products_on_organization_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "organization_id"
    t.string "first_name"
    t.string "last_name"
    t.boolean "active", default: true, null: false
    t.integer "role", default: 0, null: false
    t.bigint "location_id"
    t.index ["location_id"], name: "index_users_on_location_id"
    t.index ["organization_id"], name: "index_users_on_organization_id"
  end

  add_foreign_key "harvested_products", "harvests"
  add_foreign_key "harvested_products", "offered_products"
  add_foreign_key "harvested_products", "organizations"
  add_foreign_key "harvests", "offerings"
  add_foreign_key "harvests", "users"
  add_foreign_key "locations", "organizations"
  add_foreign_key "offered_products", "offerings"
  add_foreign_key "offered_products", "organizations"
  add_foreign_key "offered_products", "products"
  add_foreign_key "offerings", "locations"
  add_foreign_key "offerings", "organizations"
  add_foreign_key "products", "organizations"
  add_foreign_key "users", "locations"
end
