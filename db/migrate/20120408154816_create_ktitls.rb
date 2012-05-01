class CreateKtitls < ActiveRecord::Migration
  def change
    create_table :ktitls do |t|
    	t.integer :kplan_id
		t.string :pregmet
		t.string :spec
		t.string :group
		t.string :kurs
		t.string :semestr
		t.string :god
		t.string :uchregd		
		t.integer :ch_ned
		t.integer :ch_zan
		t.integer :ch_labrab
		t.integer :ch_kprtk
		t.integer :ch_smr

     	t.timestamps
    end

  end
end
