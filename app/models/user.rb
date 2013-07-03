class EmailValidator < ActiveModel::EachValidator
  EMAIL_REGEX = /\w+@[a-z]+.[a-z]+/

  def validate_each(record, attribute_name, value)
    unless value =~ EMAIL_REGEX
      record.errors[attribute_name] << (options[:message] || "Not a valid email")
    end
  end
end

class User <  ActiveRecord::Base
  has_many :long_urls, :through => :short_url
  has_many :comments
  has_many :visits
  has_many :short_urls

  attr_accessible :user_name, :email, :created_at, :updated_at

  validates :user_name, :presence => true, :uniqueness =>
            {:message => "User name already exists"}

  validates :email, :presence => true, :uniqueness => true, :email => true
end
