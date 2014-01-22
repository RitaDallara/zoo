class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :password
      t.integer :max_easy
      t.integer :max_medium
      t.integer :max_hard

      t.timestamps
    end
  end
end
