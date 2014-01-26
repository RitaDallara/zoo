class AddAttachmentSoundToAnimals < ActiveRecord::Migration
  def self.up
    change_table :animals do |t|
      t.attachment :sound
    end
  end

  def self.down
    drop_attached_file :animals, :sound
  end
end
