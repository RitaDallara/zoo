class User < ActiveRecord::Base

  after_create :assign_default_role

    def assign_default_role
      add_role(:user)
    end

    def update_max_score(diff,score)
      #ref_score = self.max_easy if diff == "easy"
      #ref_score = self.max_medium if diff == "medium"
      #ref_score = self.max_hard if diff == "hard"
      #ref_score = "max_#{diff}"
      update_attributes( :"max_#{diff}" =>  [send("max_#{diff}"), score.to_i].max  )
      #if diff == "easy"
      #  if score.to_i > self.max_easy
      #    self.max_easy= score.to_i
      #  end
	
      #elsif diff == "medium"
      #  if score.to_i > self.max_medium
      #    self.max_medium= score.to_i
      #  end
	
      #elsif diff == "hard"
	#if score.to_i > self.max_hard
	#  self.max_hard= score.to_i
	#end
      #end
      
    end
    
    def self.find_best(diff)
      User.where(diff).order(diff).reverse.first(5)
    end

	rolify

	devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
end
