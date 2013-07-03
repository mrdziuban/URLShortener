class TagValidator < ActiveRecord::EachValidator
  TAGS_ALLOWED = ["sports","news","social media"]

  def validate_each(record, attribute_name, value)
    unless TAGS_ALLOWED.include?(value)
      record.errors[attribute_name] << (options[:message] || "Tag not allowed")
    end
  end
end

class TagTopic < ActiveRecord::Base
  has_many :short_urls

  attr_accessible :tag, :short_url_id, :created_at, :updated_at

  validates :tag, :presence => true, :tag => true
  validates :short_url_id, :presence => true
  validates_uniqueness_of :tag, :scope => :short_url_id
end