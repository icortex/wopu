class AvailableTag
  include Mongoid::Document
  field :name, type: String

  has_many :tags
end
