class UpdateShortUrl < ActiveRecord::Migration
  def change
    add_column :short_urls, :user_id, :integer
  end
end