class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include DeviseStuff

  field :name, type: String
  field :email, type: String
  field :password, type: String

  mount_uploader :avatar, ImageUploader

  has_many :donations, as: :helper
  has_many :nonprofits

  validates_presence_of :email, :password

  default_scope ->{ ne _type: :Admin }
end
