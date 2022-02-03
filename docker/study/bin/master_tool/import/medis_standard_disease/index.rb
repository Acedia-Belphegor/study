module MasterTool
  module Import
    module MedisStandardDisease
      class Index
        def initialize(master_version)
          @master_version = master_version
          @source_dir = Rails.root.join("db", "medis_standard_disease", "byomei#{master_version}")
          @source_file = @source_dir.join("main", "index#{master_version}.txt")
          @header_file = @source_dir.join("option", "ttl_idx.txt")
        end

        def perform
          destroy
          
          File.open(@source_file, "r", encoding: "Windows-31J:UTF-8", invalid: :replace, undef: :replace, replace: '?') do |f|
            headers = CSV.open(@header_file, "r", encoding: "Windows-31J:UTF-8").readline
            csv = CSV.new(f, headers: headers)
            csv.each.with_index(1) do |row, index|
              Master::MedisIndex.new(
                index_term: row["索引用語"],
                term_code: row["対応用語コード"],
                disease_modifier_type: row["病名修飾語区分"],
                kana_kanji_type: row["かな漢字区分"],
                synonym_type: row["同義語区分"],
                variant_type: row["異字体区分"],
                first_edition_adoption_type: row["第１版採用表記区分"],
                language_type: row["言語区分（将来用予約）"],
                omit_type: row["省略区分（将来用予約）"],
              ).save!
            end
          end
        end

        def destroy
          Master::MedisIndex.destroy_all
        end
      end
    end
  end
end
