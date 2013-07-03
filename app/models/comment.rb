class Comment < ActiveRecord::Base
  belongs_to :short_url
  belongs_to :user
  belongs_to :visit

  attr_accessible :body, :short_url_id, :user_id, :created_at, :updated_at

  validates :body, :presence => true
  validates :short_url_id, :presence => true
  validates :user_id, :presence => true
end