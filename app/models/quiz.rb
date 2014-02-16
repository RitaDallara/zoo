class Quiz < ActiveRecord::Base

  resourcify

  belongs_to :animal, :class_name => "Animal", :foreign_key => "animal_id"
  belongs_to :alternative, :class_name => "Animal", :foreign_key => "alternative_id"
 

  def self.rand_quiz(num, diff)
    Quiz.where(id: Quiz.where(difficulty: diff).pluck(:id).sample(num.to_i))
  end

  def validate_animal 
       if animal_id.nil? 
         errors[:base] << "Please specify the first animal" 
       end 
  end

  validate :cross_quiz

  def cross_quiz
    if ((Quiz.where(animal_id: animal_id)).count>0 && (Quiz.where(alternative_id: alternative_id)).count>0) || ((Quiz.where(alternative_id: animal_id)).count>0 && (Quiz.where(animal_id: alternative_id)).count>0)
      errors[:base] << "Quiz already existing"
    end
  end 

 validate :validate_alternative 

   def validate_alternative 
        if alternative_id.nil? 
          errors[:base] << "Please specify the second animal" 
        end 
      end  
  
  validate :cant_nominate_self  

    def cant_nominate_self
      if (animal_id == alternative_id) && (not(animal_id.nil?)) && (not(alternative_id.nil?))
      errors[:base] << "Please, choose two different animals"
      end
    end
    

 validate :validate_difficulty 

   def validate_difficulty 
        if difficulty.nil? 
          errors[:base] << "Please specify the difficulty" 
        end 
      end  
end
