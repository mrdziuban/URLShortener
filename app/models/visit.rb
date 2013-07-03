class Visit < ActiveRecord::Base
  belongs_to :short_url
  belongs_to :user

  attr_accessible :short_url_id, :user_id, :created_at, :updated_at

  validates :short_url_id, :presence => true
  validates :user_id, :presence => true
end