class Animal < ActiveRecord::Base
  resourcify

  has_many :quizzes, :dependent => :destroy
  
  has_attached_file :avatar, :styles => { :medium => "1300x1300>", :thumb => "100x100>" }#,
  
		    #:default_url => "/images/:style/missing.png"


 
 has_attached_file :sound 
 
 
 validates :name, :presence => :true, :uniqueness => { :case_sensitive => false }, :format => { :with => %r{\A[A-Z][a-zA-Z\s]*\z}, :allow_blank => true}
 
 #validate :name_format
 
 
 
 
 validates_attachment_presence :avatar
 
 #validates_attachment_content_type :avatar, 
  #               :content_type => ['image/*']

validates_attachment_presence :sound
 

validates_attachment_content_type :sound, 
                :content_type => [ 'application/mp3', 'application/x-mp3', 'application/force-download', 'audio/mpeg', 'audio/mp3' ], 
               :message => 'file must be of filetype .mp3' 



end


