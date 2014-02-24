class Quiz < ActiveRecord::Base
  resourcify

  belongs_to :animal, :class_name => "Animal", :foreign_key => "animal_id"
  belongs_to :alternative, :class_name => "Animal", :foreign_key => "alternative_id"
  
  validate :validate_animal
  validate :cross_quiz
  validate :validate_alternative
  validate :cant_nominate_self
  validate :validate_difficulty
  
  
  # random quiz sequence generation, of length num and made up of quizzes of difficulty diff
  def self.rand_quiz(num, diff)
    Quiz.where(id: Quiz.where(difficulty: diff).pluck(:id).sample(num.to_i))
  end
  
  # minimum number of quizzes across all levels of difficulty
  def self.min_amount
    [Quiz.where(difficulty: "hard").count, Quiz.where(difficulty: "medium").count, Quiz.where(difficulty: "easy").count].min
  end
  
  

  private

  def validate_animal 
    if animal_id.nil? 
      errors[:base] << "Please specify the first animal" 
    end 
  end


  # quiz is already existing if an identical one exists, or if one associated to the same animals
  # but with switched positions exists
  def cross_quiz
    straight_dups = Quiz.where(animal_id: animal_id, alternative_id: alternative_id)
    cross_dups = Quiz.where(alternative_id: animal_id, animal_id: alternative_id)
    if (straight_dups.count>0 || cross_dups.count>0)
      errors[:base] << "Quiz already existing" unless (straight_dups.where(id: self.id).count>0 || cross_dups.where(id: self.id).count>0)
    end
  end

 

  def validate_alternative 
    if alternative_id.nil? 
      errors[:base] << "Please specify the second animal" 
    end 
  end  
  
 

  def cant_nominate_self
    if (animal_id == alternative_id) && (not(animal_id.nil?)) && (not(alternative_id.nil?))
	errors[:base] << "Please, choose two different animals"
    end
  end
    

  def validate_difficulty 
    if difficulty.nil? 
	errors[:base] << "Please specify the difficulty" 
    end 
   end  
end
