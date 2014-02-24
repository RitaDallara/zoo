class Setting < ActiveRecord::Base

  validates_presence_of [:optone, :opttwo, :optthree]
  validates_numericality_of [:optone, :opttwo, :optthree], :greater_than => 0, :allow_blank => :true
  validate :enough_quizzes_for_setting
  
  private
  
  # you can't let the user ask for 33 quizzes if you only have 30...
  # (this is a more restrictive validation than necessary, but it should have otherwise evaluted
  # at runtime)
  def enough_quizzes_for_setting
    
    if not(optone.nil?)
      if optone > Quiz.min_amount
	errors[:base] << "There aren't enough quizzes for option one!"
      end
    end
    
    if not(opttwo.nil?)
      if opttwo > Quiz.min_amount
	errors[:base] << "There aren't enough quizzes for option two!"
      end
    end
    
    if not(optthree.nil?)
      if optthree > Quiz.min_amount
	errors[:base] << "There aren't enough quizzes for option three!"
      end
    end
  end
  
end
