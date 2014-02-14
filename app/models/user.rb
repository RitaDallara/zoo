class User < ActiveRecord::Base

  after_create :assign_default_role

    def assign_default_role
      add_role(:user)
    end

	rolify

	devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
end
