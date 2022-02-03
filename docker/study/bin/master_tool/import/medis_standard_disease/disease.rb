module MasterTool
  module Import
    module MedisStandardDisease
      class Disease
        def initialize(master_version)
          @master_version = master_version
          @source_dir = Rails.root.join("db", "medis_standard_disease", "byomei#{master_version}")
          @source_file = @source_dir.join("main", "nmain#{master_version}.txt")
          @header_file = @source_dir.join("option", "ttl_main.txt")
        end

        def perform
          destroy
          
          File.open(@source_file, "r", encoding: "Windows-31J:UTF-8", invalid: :replace, undef: :replace, replace: '?') do |f|
            headers = CSV.open(@header_file, "r", encoding: "Windows-31J:UTF-8").readline
            csv = CSV.new(f, headers: headers)
            csv.each.with_index(1) do |row, index|
              Master::MedisDisease.new(
                change_type: row["変更区分"],
                disease_managed_number: row["病名管理番号"],
                disease_name: row["病名表記"],
                disease_phonetic_name: row["病名表記カナ"],
                adoption_type: row["採択区分"],
                disease_exchange_code: row["病名交換用コード"],
                icd10_2013: row["ＩＣＤ１０‐２０１３"],
                icd10_2013_multiple_class_code: row["ＩＣＤ１０‐２０１３複数分類コード"],
                reserve1: row["予備１"],
                reserve2: row["予備２"],
                receipt_code: row["レセ電算コード"],
                disease_short_name: row["傷病名省略名称"],
                usage_division: row["使用分野"],
                change_history_number: row["変更履歴番号"],
                update_date: row["更新日付"],
                migrated_disease_managed_number: row["移行先病名管理番号"],
                prohibition_use_alone_type: row["単独使用禁止区分"],
                uncoverd_insurance_type: row["保険請求外区分"],
                reserve3: row["予備３"],
                reserve4: row["予備４"]
              ).save!
            end
          end
        end

        def destroy
          Master::MedisDisease.destroy_all
        end
      end
    end
  end
end
