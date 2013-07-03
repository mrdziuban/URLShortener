class ShortUrl < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  has_many :visits
  has_many :tag_topics

  attr_accessible :url, :user_id, :long_url_id, :created_at, :updated_at

  validates :long_url_id, :presence => true
  validates :url, :presence => true
  validates :user_id, :presence => true
end