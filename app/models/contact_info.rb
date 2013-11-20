class ContactInfo
  include Mongoid::Document
  include Mongoid::Timestamps

  field :email
  field :phone
  field :address
  field :representative

  embedded_in :nonprofit
end