class User < ActiveRecord::Base
  after_create :assign_default_role

  validates :username, :presence => :true
  
  rolify
  
  devise :database_authenticatable, :registerable, :rememberable, :trackable, :validatable



  def update_max_score(difficulty,score)
    update_attributes( :"max_#{difficulty}" =>  [send("max_#{difficulty}"), score.to_i].max  )
  end
    
  def self.find_best(diff)
    User.where(diff).order(diff).reverse.first(5)
  end





  private
  
  def assign_default_role
    add_role(:user)
  end
  
end
