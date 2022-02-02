# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Patient.create!(
  name: "児玉　義憲",
  kana_name: "コダマ　ヨシノリ",
  gender: "male",
  birth_date: Date.parse("1979-11-01"),
  addresses: [
    Address.new(
      use: "home",
      postal_code: "1730004",
      prefecture: "東京都",
      city: "板橋区",
      line: "板橋１丁目６０−１"
    )
  ],
  insurances: [
    Insurance.new(
      insurance_number: "06139999",
      insured_symbol: "12345678",
      insured_number: "4320",
      insured_branch_number: "00",
      relationship: "person",
      start_at: "20180718",
      end_at: "99999999"
    )
  ],
  memo: PatientMemo.new(content: "ほげほげ")
)
