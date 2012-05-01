class CreateKlits < ActiveRecord::Migration
  def change
    create_table :klits do |t|
      t.integer :kplan_id
      t.integer :nomer_srt
      t.string :literatura

      t.timestamps
    end
  end
end
