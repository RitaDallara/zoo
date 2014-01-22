class CreateAnimals < ActiveRecord::Migration
  def change
    create_table :animals do |t|
      t.string :name
      t.string :image
      t.string :sound

      t.timestamps
    end
  end
end
