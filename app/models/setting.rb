class Setting < ActiveRecord::Base
  #validates :optone, :presence => :true
  #validates :opttwo, :presence => :true
  #validates :optthree, :presence => :true
  validates_presence_of [:optone, :opttwo, :optthree]
  validates_numericality_of [:optone, :opttwo, :optthree], :greater_than => 0, :allow_blank => :true
  validate :enough_quizzes_for_setting
  
  private
  
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
