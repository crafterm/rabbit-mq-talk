class Photo < ActiveRecord::Base
  
  # ===============
  # = Validations =
  # ===============
  validates_presence_of :name, :description
  
  # ================
  # = Associations =
  # ================
  has_many :assets, :dependent => :destroy
  
end
