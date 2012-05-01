class CreateKbodies < ActiveRecord::Migration
  def change
    create_table :kbodies do |t|
      t.integer :kplan_id
      t.integer :nomer_page
      t.integer :nomer_str
      t.string :nomer_uroka
      t.string :tema_zaniatia
      t.string :nomer_nedeli
      t.integer :kolvo_chasov
      t.string :vid_zaniatia
      t.string :nagl_posobie
      t.string :zadano
      t.string :samrab_casov
      t.string :samrab_zadanie

      t.timestamps
    end
  end
end
