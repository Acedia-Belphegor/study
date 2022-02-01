class CreatePatients < ActiveRecord::Migration[7.0]
  def change
    enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')
    create_table :patients, id: :uuid do |t|
      t.string :name
      t.string :kana_name
      t.string :gender
      t.date :birth_date

      t.timestamps
    end
  end
end
