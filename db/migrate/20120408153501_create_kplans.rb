class CreateKplans < ActiveRecord::Migration
  def change
    create_table :kplans do |t|
      t.integer :user_id
      t.integer :predmet_comissia

      t.timestamps
    end
  end
end
