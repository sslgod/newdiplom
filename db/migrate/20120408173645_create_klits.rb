class CreateKlits < ActiveRecord::Migration
  def change
    create_table :klits do |t|
      t.integer :kplan_id
      (1..24).each do |i|
      	t.string "literatura#{i}"
  	  end
      t.timestamps
    end
  end
end
