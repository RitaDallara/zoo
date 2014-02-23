class Animal < ActiveRecord::Base
  resourcify

  has_many :quizzes, :dependent => :destroy
  
  has_attached_file :avatar, :styles => { :medium => "640x640>", :thumb => "100x100>" }


 
  has_attached_file :sound 
 
 
  validates :name, :presence => :true, :uniqueness => { :case_sensitive => false }, :format => { :with => %r{\A[A-Z][a-zA-Z\s]*\z}, :allow_blank => true}
 

  validates_attachment_presence :avatar


  validates_attachment_presence :sound
 

  validates_attachment_content_type :sound, 
                :content_type => [ 'application/mp3', 'application/x-mp3', 'application/force-download', 'audio/mpeg', 'audio/mp3' ], 
               :message => 'file must be of filetype .mp3' 

end


