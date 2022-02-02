class CreatePatients < ActiveRecord::Migration[7.0]
  def change
    create_table :patients, id: :uuid do |t|
      t.string :name
      t.string :kana_name
      t.string :gender
      t.date :birth_date

      t.timestamps
    end
  end
end
