class TagTopic < ActiveRecord::Base
  has_many :short_urls

  attr_accessible :tag, :short_url_id, :created_at, :updated_at

  validates :tag, :presence => true
  validates :short_url_id, :presence => true
end