class CreateKbodies < ActiveRecord::Migration
  def change
    create_table :kbodies do |t|
      t.integer :kplan_id
      t.integer :nomer_page
      (1..26).each do |i|
        t.string "nomer_uroka#{i}"
        t.string "tema_zaniatia#{i}"
        t.string "nomer_nedeli#{i}"
        t.integer "kolvo_chasov#{i}"
        t.string "vid_zaniatia#{i}"
        t.string "nagl_posobie#{i}"
        t.string "zadano#{i}"
        t.string "samrab_casov#{i}"
        t.string "samrab_zadanie#{i}"
      end
      t.timestamps
    end
  end
end
