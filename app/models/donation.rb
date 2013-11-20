class Donation
  include Mongoid::Document
  include Mongoid::Timestamps

  field :description, type: String
  field :accepted, type: Boolean, default: nil # nil = Pending
  field :suggested, type: Boolean, default: false

  belongs_to :need
  belongs_to :helper, polymorphic: true

  validates_presence_of :description, :helper

  scope :available, ->{ where(suggested: true, accepted: nil) }
  scope :pending, ->{ where(suggested: false, accepted: nil) }

  def accept!
    self.accepted = true
    self.save
  end

  def reject!
    self.accepted = false
    self.need = nil
    self.save
  end
end
