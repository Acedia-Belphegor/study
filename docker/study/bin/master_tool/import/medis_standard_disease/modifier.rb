module MasterTool
  module Import
    module MedisStandardDisease
      class Modifier
        def initialize(master_version)
          @master_version = master_version
          @source_dir = Rails.root.join("db", "medis_standard_disease", "byomei#{master_version}")
          @source_file = @source_dir.join("main", "mdfy#{master_version}.txt")
          @header_file = @source_dir.join("option", "ttl_mdfy.txt")
        end

        def perform
          destroy
          
          File.open(@source_file, "r", encoding: "Windows-31J:UTF-8", invalid: :replace, undef: :replace, replace: '?') do |f|
            headers = CSV.open(@header_file, "r", encoding: "Windows-31J:UTF-8").readline
            csv = CSV.new(f, headers: headers)
            csv.each.with_index(1) do |row, index|
              Master::MedisModifier.new(
                change_type: row["変更区分"],
                modifier_managed_number: row["修飾語管理番号"],
                modifier_name: row["修飾語表記"],
                modifier_phonetic_name: row["修飾語表記カナ"],
                modifier_exchange_code: row["修飾語交換用コード"],
                location_type: row["接続位置区分"],
                modifier_type: row["修飾語区分"],
                exclusive_group_code: row["排他グループコード"],
                receipt_modifier_code: row["レセ電算修飾語コード"],
                description_label: row["修飾語説明用ラベル"]
              ).save!
            end
          end
        end

        def destroy
          Master::MedisModifier.destroy_all
        end
      end
    end
  end
end
