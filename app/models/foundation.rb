class Foundation
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Attributes::Dynamic

  field :name
  field :mission
  field :population
  field :start_date, type: DateTime
  field :certified, type: Boolean, default: false

  mount_uploader :logo, ImageUploader

  embeds_one :contact_info

  belongs_to :category
  belongs_to :user
  has_many :needs
  has_many :helps, as: :helper
  has_many :tags, as: :taggeable

  accepts_nested_attributes_for :contact_info
  accepts_nested_attributes_for :user

  validates_presence_of :name
  validates_associated :user

  attr_accessor :available_tag_ids

  after_validation :handle_post_validation
  after_save :recreate_tags

  def handle_post_validation
    unless self.errors[:user].nil?
      self.user.errors.each{ |attr, msg| self.errors.add(attr, msg)}
      self.errors.delete(:user)
    end
  end
  private :handle_post_validation

  def recreate_tags
    tags.destroy_all
    create_tags
  end

  def create_tags
    (available_tag_ids || []).each do |at_id|
      if at_id.present?
        Tag.create available_tag_id: at_id, taggeable_id: id, taggeable_type: self.class.name
      end
    end
  end
end
