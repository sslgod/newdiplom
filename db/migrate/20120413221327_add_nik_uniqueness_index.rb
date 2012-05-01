class AddNikUniquenessIndex < ActiveRecord::Migration
  def up
  	add_index :users, :nik, :unique => true
  end

  def down
  	remove_index :users, :nik
  end
end
