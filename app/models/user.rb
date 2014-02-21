class User < ActiveRecord::Base

  after_create :assign_default_role

  validates :username, :presence => :true



  def update_max_score(diff,score)
    update_attributes( :"max_#{diff}" =>  [send("max_#{diff}"), score.to_i].max  )
  end
    
  def self.find_best(diff)
    User.where(diff).order(diff).reverse.first(5)
  end



  rolify
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  private
  
  def assign_default_role
    add_role(:user)
  end
  
end
