class User < ActiveRecord::Base
  after_create :assign_default_role

  validates :username, :presence => :true
  
  rolify
  
  devise :database_authenticatable, :registerable, :rememberable, :trackable, :validatable

  # the user's top score in this difficulty level is updated only if current score is higher
  def update_max_score(difficulty,score)
    update_attributes( :"max_#{difficulty}" =>  [send("max_#{difficulty}"), score.to_i].max  )
  end
  
  # find the 5 highest scoring players at the given level of difficulty
  def self.find_best(diff)
    User.where(diff).order(diff).reverse.first(5)
  end


  private
  
  def assign_default_role
    add_role(:user)
  end
  
end
