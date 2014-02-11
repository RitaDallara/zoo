

class Animal < ActiveRecord::Base
  resourcify



  has_attached_file :avatar, :styles => { :medium => "1300x1300>", :thumb => "100x100>" },
		    :default_url => "/images/:style/missing.png"


 # has_attached_file :sound, :styles => {:ogg => ['ogg', :ogg] }, :processors => [:ogg]
 has_attached_file :sound # :styles => {:mp3 => ['mp3', :mp3] }, :processors => [:ogg]
 
 #validates_attachment_presence :image
 
 validates :name, :presence => :true, :uniqueness => { :case_sensitive => false }, :format => { :with => %r{\A[A-Z][a-zA-Z\s]*\z}}
 
 validates_attachment_presence :avatar

validates_attachment_presence :sound
 

validates_attachment_content_type :sound, 
                :content_type => [ 'application/mp3', 'application/x-mp3', 'application/force-download', 'audio/mpeg', 'audio/mp3' ], 
               :message => 'file must be of filetype .mp3' 



end
