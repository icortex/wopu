class Need
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title
  field :purpose # What for?
  field :description, type: String # The petition
  field :open, type: Boolean, default: true
  field :beneficiary
  field :deadline, type: DateTime
   # See what happened after the need was marked as close? Show results?
   #has_many :pictures

  belongs_to :nonprofit
  has_many :helps
  has_many :tags, as: :taggeable
  has_one :result

  validates_presence_of :description

  scope :active, ->() { where(open: true) }
  scope :inactive, ->() { where(open: false) }

  def solve!
    self.open = false
    self.save
  end
end
