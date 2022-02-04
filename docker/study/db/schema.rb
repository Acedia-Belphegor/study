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

ActiveRecord::Schema.define(version: 2022_02_02_055017) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "addresses", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.text "use"
    t.text "postal_code"
    t.text "prefecture"
    t.text "city"
    t.text "line"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "diseases", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "patient_id"
    t.string "disease_code"
    t.string "disease_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["patient_id"], name: "index_diseases_on_patient_id"
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
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["patient_id"], name: "index_insurances_on_patient_id"
  end

  create_table "master_icd10_basic_classes", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "kind", comment: "種別"
    t.string "class_unit", comment: "分類単位"
    t.string "chapter_number", comment: "章番号"
    t.string "intermediate_class", comment: "中間分類"
    t.string "three_digits_class", comment: "３桁分類"
    t.string "code", comment: "コード"
    t.string "kensei", comment: "剣星"
    t.string "display_code", comment: "表示用コード"
    t.string "sub_class", comment: "注、細分類等"
    t.string "name", comment: "コード名"
    t.string "large_class", comment: "大分類"
    t.string "middle_class", comment: "中分類"
    t.string "small_class", comment: "小分類"
    t.string "case_of_death_class", comment: "死因分類"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["code"], name: "index_master_icd10_basic_classes_on_code"
  end

  create_table "master_medis_diseases", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "change_type", comment: "変更区分"
    t.string "disease_managed_number", comment: "病名管理番号"
    t.string "disease_name", comment: "病名表記"
    t.string "disease_phonetic_name", comment: "病名表記カナ"
    t.string "adoption_type", comment: "採択区分"
    t.string "disease_exchange_code", comment: "病名交換用コード"
    t.string "icd10_2013", comment: "ＩＣＤ１０‐２０１３"
    t.string "icd10_2013_multiple_class_code", comment: "ＩＣＤ１０‐２０１３複数分類コード"
    t.string "reserve1", comment: "予備１"
    t.string "reserve2", comment: "予備２"
    t.string "receipt_code", comment: "レセ電算コード"
    t.string "disease_short_name", comment: "傷病名省略名称"
    t.string "usage_division", comment: "使用分野"
    t.string "change_history_number", comment: "変更履歴番号"
    t.string "update_date", comment: "更新日付"
    t.string "migrated_disease_managed_number", comment: "移行先病名管理番号"
    t.string "prohibition_use_alone_type", comment: "単独使用禁止区分"
    t.string "uncoverd_insurance_type", comment: "保険請求外区分"
    t.string "reserve3", comment: "予備３"
    t.string "reserve4", comment: "予備４"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["disease_managed_number"], name: "index_master_medis_diseases_on_disease_managed_number"
    t.index ["receipt_code"], name: "index_master_medis_diseases_on_receipt_code"
  end

  create_table "master_medis_indices", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "index_term", comment: "索引用語"
    t.string "term_code", comment: "対応用語コード"
    t.string "disease_modifier_type", comment: "病名修飾語区分"
    t.string "kana_kanji_type", comment: "かな漢字区分"
    t.string "synonym_type", comment: "同義語区分"
    t.string "variant_type", comment: "異字体区分"
    t.string "first_edition_adoption_type", comment: "第１版採用表記区分"
    t.string "language_type", comment: "言語区分（将来用予約）"
    t.string "omit_type", comment: "省略区分（将来用予約）"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["index_term", "disease_modifier_type"], name: "index_master_medis_indexes_on_index_term"
    t.index ["term_code"], name: "index_master_medis_indexes_on_term_code"
  end

  create_table "master_medis_modifiers", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "change_type", comment: "変更区分"
    t.string "modifier_managed_number", comment: "修飾語管理番号"
    t.string "modifier_name", comment: "修飾語表記"
    t.string "modifier_phonetic_name", comment: "修飾語表記カナ"
    t.string "modifier_exchange_code", comment: "修飾語交換用コード"
    t.string "location_type", comment: "接続位置区分"
    t.string "modifier_type", comment: "修飾語区分"
    t.string "exclusive_group_code", comment: "排他グループコード"
    t.string "receipt_modifier_code", comment: "レセ電算修飾語コード"
    t.string "description_label", comment: "修飾語説明用ラベル"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["modifier_managed_number"], name: "index_master_medis_modifiers_on_modifier_managed_number"
    t.index ["receipt_modifier_code"], name: "index_master_medis_modifiers_on_receipt_modifier_code"
  end

  create_table "patient_addresses", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "patient_id"
    t.uuid "address_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["address_id"], name: "index_patient_addresses_on_address_id"
    t.index ["patient_id"], name: "index_patient_addresses_on_patient_id"
  end

  create_table "patient_memos", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "patient_id"
    t.text "content", default: "", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["patient_id"], name: "index_patient_memos_on_patient_id", unique: true
  end

  create_table "patients", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.text "name"
    t.text "kana_name"
    t.string "gender"
    t.date "birth_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
