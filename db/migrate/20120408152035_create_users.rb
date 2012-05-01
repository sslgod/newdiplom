class CreateUsers < ActiveRecord::Migration
  def change
   create_table(:users) do |t|
     
      
      t.string :nik
      t.string :name
      t.string :pas
      t.string :salt
      t.integer :tip
      t.integer :predmet_comissia

      t.timestamps
    end
  end
end
