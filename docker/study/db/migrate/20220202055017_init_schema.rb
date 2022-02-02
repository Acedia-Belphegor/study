class InitSchema < ActiveRecord::Migration[7.0]
  def up
    enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')

    create_table "addresses", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
      t.text "use"
      t.text "postal_code"
      t.text "prefecture"
      t.text "city"
      t.text "line"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end

    create_table "insurances", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
      t.uuid "patient_id"
      t.string "insurance_number"
      t.string "insured_symbol"
      t.string "insured_number"
      t.string "insured_branch_number"
      t.string "insured_name"
      t.string "relationship"
      t.string "start_at"
      t.string "end_at"
      t.integer "payment_rate_for_outpatient", limit: 2, default: 100
      t.integer "payment_rate_for_inpatient", limit: 2, default: 100
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["patient_id"], name: "index_insurances_on_patient_id"
    end

    create_table "patients", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
      t.text "name"
      t.text "kana_name"
      t.string "gender"
      t.date "birth_date"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end

    create_table "patient_addresses", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
      t.uuid "patient_id"
      t.uuid "address_id"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["address_id"], name: "index_patient_addresses_on_address_id"
      t.index ["patient_id"], name: "index_patient_addresses_on_patient_id"
    end

    create_table "patient_memos", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
      t.uuid "patient_id"
      t.text "content", default: "", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["patient_id"], name: "index_patient_memos_on_patient_id", unique: true
    end  
  end
end
