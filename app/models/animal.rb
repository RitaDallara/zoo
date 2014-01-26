class Animal < ActiveRecord::Base
  resourcify

  has_attached_file :avatar, :styles => { :medium => "1300x1300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
end
