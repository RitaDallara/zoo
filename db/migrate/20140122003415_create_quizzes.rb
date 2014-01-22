class CreateQuizzes < ActiveRecord::Migration
  def change
    create_table :quizzes do |t|
      t.integer :animal_id
      t.integer :alternative_id
      t.string :difficulty

      t.timestamps
    end
  end
end
