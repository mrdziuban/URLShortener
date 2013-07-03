class UrlValidator < ActiveModel::EachValidator
  HTTP_URL = /http:\/\/\w+.[a-z]+\S+/
  HTTPS_URL = /https:\/\/\w+.[a-z]+\S+/

  def validate_each(record, attribute_name, value)
    unless value =~ HTTPS_URL || value =~ HTTP_URL
      record.errors[attribute_name] << (options[:message] || "Not a valid url")
    end
    unless value.length < 1024
      record.errors[attribute_name] << (options[:message] || "url too long")
    end
  end
end

class LongUrl < ActiveRecord::Base
  belongs_to :short_url

  attr_accessible :url, :created_at, :updated_at

  validates :url, :presence => true, :uniqueness => true, :url => true
end