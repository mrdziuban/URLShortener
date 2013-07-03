class UpdateLongUrl < ActiveRecord::Migration
  def change
    rename_column :long_urls, :user_id, :short_url_id
  end
end
