class Quiz < ActiveRecord::Base

  resourcify

  belongs_to :animal, :class_name => "Animal", :foreign_key => "animal_id"
  belongs_to :alternative, :class_name => "Animal", :foreign_key => "alternative_id"

end
