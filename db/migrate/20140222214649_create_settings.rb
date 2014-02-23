class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.integer :optone
      t.integer :opttwo
      t.integer :optthree

      t.timestamps
    end
  end
end
