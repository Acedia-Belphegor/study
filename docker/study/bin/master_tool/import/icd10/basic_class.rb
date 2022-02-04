# https://www.mhlw.go.jp/toukei/sippei/
module MasterTool
  module Import
    module Icd10
      class BasicClass
        def initialize(master_version)
          @master_version = master_version
          @source_file = Rails.root.join("db", "icd10", master_version, "kihon#{master_version}.csv")
        end

        def perform
          $stderr.puts "【ICD10基本分類表】インポート開始"
          destroy
          
          File.open(@source_file, "r", encoding: Encoding::UTF_8, invalid: :replace, undef: :replace, replace: '?') do |f|
            csv = CSV.new(f, headers: true)
            csv.each do |row|
              Master::Icd10BasicClass.new(
                kind: row["種別"],
                class_unit: row["分類単位"],
                chapter_number: row["章番号"],
                intermediate_class: row["中間分類"],
                three_digits_class: row["３桁分類"],
                code: row["コード"],
                kensei: row["剣星"],
                display_code: row["表示用コード"],
                sub_class: row["注、細分類等"],
                name: row["コード名"],
                large_class: row["大分類"],
                middle_class: row["中分類"],
                small_class: row["小分類"],
                case_of_death_class: row["死因分類"]
              ).save!
            end
          end

          $stderr.puts "【ICD10基本分類表】インポート完了"
        end

        def destroy
          Master::Icd10BasicClass.destroy_all
        end
      end
    end
  end
end
